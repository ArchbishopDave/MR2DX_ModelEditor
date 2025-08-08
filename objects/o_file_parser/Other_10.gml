m_filename = get_open_filename_ext("*", "", "","Open File");
var buffer = 0;
if ( m_filename != "" ) {
    
    buffer = buffer_load(m_filename);
    buffer_seek(buffer, buffer_seek_start, 0);
    m_valid_file = true;
 }


if ( m_valid_file ) {
    var strips_parsed = 0;
    
    
    buffer_seek(buffer, buffer_seek_start, 0);
    
    var reading_mr_data = true;
    while ( reading_mr_data ) {
        var mrdata = buffer_read(buffer, buffer_s16);
        
        if ( mrdata == 65 ) {
            reading_mr_data = false;
            buffer_seek(buffer, buffer_seek_relative, 6);
            m_tmd_header_start = buffer_tell(buffer);
            m_tmd_data_count = buffer_read(buffer, buffer_u32);
        }
    }
    
    
    
    var headerVertexCount = 0;
    var group_sizes = [];
    var strip_group_count = [];
    
    var reading_tmd_header = 0;
    var min_vertex_start = 9999999;
    
    var tmd_data_position = -1;
    
    while ( reading_tmd_header < m_tmd_data_count ) {
        var vertp = m_tmd_header_start + buffer_read(buffer, buffer_u16);
        var vertc = buffer_read(buffer, buffer_u16);
        var normp = m_tmd_header_start + buffer_read(buffer, buffer_u16);
        var normc = buffer_read(buffer, buffer_u16);
        var polyp = m_tmd_header_start + buffer_read(buffer, buffer_u16);
        var polyc = buffer_read(buffer, buffer_u16);
        
        var tmdheader = {
            vertex_offset : vertp,
            vertex_count : vertc,
            normal_offset : normp,
            normal_count : normc,
            polygon_offset : polyp,
            polygon_count : polyc,
        }
        
        m_tmd_data[reading_tmd_header] = tmdheader;
        
        min_vertex_start = min(min_vertex_start, vertp);
        
        tmd_data_position = buffer_tell(buffer);
    }
    
    // Create Vertices
    for ( var i = 0; i < m_tmd_data_count; i++ ) {
        var tmdheader = m_tmd_data[i];
        buffer_seek(buffer, buffer_seek_start, tmdheader.vertex_offset);
        
        var vertidstart = (tmdheader.vertex_offset - min_vertex_start) / 8;
        
        for ( var j = 0; j < tmdheader.vertex_count; j++ ) {
            var vx = buffer_read(buffer, buffer_s16);
        var vy = buffer_read(buffer, buffer_s16);
        var vz = buffer_read(buffer, buffer_s16);
        var vq = buffer_read(buffer, buffer_s16); 
        }
    }
    
    buffer_seek(buffer, buffer_seek_start, tmd_data_position);
    for ( var i = 0; i < m_tmd_data_count; i++ ) {
        buffer_seek(buffer, buffer_seek_relative, 1);
        var primitve_length = buffer_read(buffer, buffer_u8);
        
        if ( primitve_length == 6 ) {
            buffer_seek(buffer, buffer_seek_relative, 2); // Skipping Mode
            
            buffer_seek(buffer, buffer_seek_relative, 12); // Skipping UV Data
            
            
            
            
        }
    }
    
    var reading_tmd_data = true;
    while(reading_tmd_data) {
        var vc = buffer_read(buffer, buffer_s16);
        
        if ( vc != headerVertexCount ) {
            array_push(group_sizes, vc);
            headerVertexCount += vc;
        }
        
        buffer_seek(buffer, buffer_seek_relative, 6);
        var stripc = buffer_read(buffer, buffer_s16);
        array_push(strip_group_count, stripc);
        
        buffer_seek(buffer, buffer_seek_relative, 6);
        
        var buff_type_1 = buffer_read(buffer, buffer_s16);
        var buff_type_2 = buffer_read(buffer, buffer_s16);
        if ( f_valid_tristrip_header(buff_type_1, buff_type_2) ||
            f_valid_quadstrip_header(buff_type_1, buff_type_2) ) {
            reading_tmd_data = false;
        }
        
        else {
            buffer_seek(buffer, buffer_seek_relative, 8);
       }
    }
    

    var current_group = 0;
    var current_offset = 0;
    var strips_remaining = strip_group_count[current_group];
    
    var verts = [-1, -1, -1, -1];
    var reading_tris = true;
    while ( reading_tris ) {
        var buff_type_1 = buffer_read(buffer, buffer_s16);
        var buff_type_2 = buffer_read(buffer, buffer_s16);
        
        
        if ( f_valid_tristrip_header(buff_type_1, buff_type_2) ) { // 3 Vertex Tri
            buffer_seek(buffer, buffer_seek_relative, 12);
            
            verts[0] = buffer_read(buffer, buffer_s16);
            buffer_seek(buffer, buffer_seek_relative, 2);
        
            verts[1] = buffer_read(buffer, buffer_s16);
            buffer_seek(buffer, buffer_seek_relative, 2);
            
            verts[2] = buffer_read(buffer, buffer_s16);
            buffer_seek(buffer, buffer_seek_relative, 2);
            
        
            o_vertex_display.f_create_connected_vertices(current_group, current_offset, verts[0], verts[1], verts[2]);                                                                               
            strips_parsed++;
            strips_remaining--;
            show_debug_message($"VERT {verts[0]}, {verts[1]}, {verts[2]}");
        }
        
        else if ( f_valid_quadstrip_header(buff_type_1, buff_type_2) ) { // 4 Vertex Quad
            buffer_seek(buffer, buffer_seek_relative, 16);
            
            
            verts[0] = buffer_read(buffer, buffer_s16);
            buffer_seek(buffer, buffer_seek_relative, 2);
        
            verts[1] = buffer_read(buffer, buffer_s16);
            buffer_seek(buffer, buffer_seek_relative, 2);
            
            verts[2] = buffer_read(buffer, buffer_s16);
            buffer_seek(buffer, buffer_seek_relative, 2);
            
            verts[3] = buffer_read(buffer, buffer_s16);
            buffer_seek(buffer, buffer_seek_relative, 2);
        
            o_vertex_display.f_create_connected_vertices(current_group, current_offset, verts[0], verts[1], verts[2], verts[3]);
            strips_parsed++;
            strips_remaining--;
            show_debug_message($"VERT {verts[0]}, {verts[1]}, {verts[2]}, {verts[3]}");
        }
        
        else if ( strips_parsed > 0 ) {
            show_debug_message($"Strips Parsed: {strips_parsed}");
            reading_tris = false;
            buffer_seek(buffer, buffer_seek_relative, -4);
            
        }
        
        if ( strips_remaining <= 0 ) {
            current_group++;
            strips_remaining = strip_group_count[current_group];
            
            
            if ( array_length(group_sizes) <= current_group ) {
                current_offset = 0;
            } else {
                current_offset = current_offset + group_sizes[current_group];
            }
        }
        
        
    }
    
    var reading_vertices = true;
    var current_vertex = 0;
    
    while ( reading_vertices ) {
        var vx = buffer_read(buffer, buffer_s16);
        var vy = buffer_read(buffer, buffer_s16);
        var vz = buffer_read(buffer, buffer_s16);
        var vq = buffer_read(buffer, buffer_s16);  
        
        show_debug_message($"Vertex Read {vx} {vy} {vz} {vq}");
        
        if ( vx != 0 || vy != 0 || vz != 0 || vq != 0  ) {
            if ( current_vertex < headerVertexCount) {
                show_debug_message($"Setting Vertex Data for {current_vertex} vs {headerVertexCount}");
                o_vertex_display.f_set_vertex_data(current_vertex, vx, vy, vz, vq);
                current_vertex++;
            }
        }
        
        else {
            var checker1 = buffer_read(buffer, buffer_s16);
            var checker2 = buffer_read(buffer, buffer_s16);
            var checker3 = buffer_read(buffer, buffer_s16);
            var checker4 = buffer_read(buffer, buffer_s16);
            
            if ( checker1 == 0 && checker2 == 0 && checker3 == 0 && checker4 == 0 ) {
                reading_vertices = false;
            }
        
            else {
                buffer_seek(buffer, buffer_seek_relative, -8);
                if ( current_vertex < headerVertexCount ) {
                    show_debug_message($"Setting Vertex Data for {current_vertex} vs {headerVertexCount}");
                    o_vertex_display.f_set_vertex_data(current_vertex, vx, vy, vz, vq);
                    current_vertex++;
                }
            }
       }
    }
    
    o_vertex_display.m_group_current = -1;
    o_vertex_display.m_group_count = array_length(group_sizes);
        

}
        


        
    