m_active_x = true;
m_active_y = true;
m_active_z = false;

d_mode_text = "XY Projection";

m_group_count = 0;
m_group_current = -1;

m_vertex_count = 0;
m_vertices = [];

d_sxyz = 50;
m_vmax = [ 1, 1, 1 ];
m_vmin = [ -1, -1, -1];

m_current_vertex = -1;

m_vc_min = 0;
m_vc_max = 9999;

for ( var i = 0; i < 5000; i++ ) {
    m_vertices[i] = -1;
}

f_connect_vertices = function (group, offset, v1, v2, v3, v4 = -1 ) {
    
    v1 = v1 + offset;
    v2 = v2 + offset;
    v3 = v3 + offset;
    v4 = v4 + offset;
    
    array_push_unique(m_vertices[v1].m_groups, group );
    array_push_unique(m_vertices[v2].m_groups, group );
    array_push_unique(m_vertices[v3].m_groups, group );
    
    
    array_push_unique(m_vertices[v1].m_connected_vertices, v2);
    array_push_unique(m_vertices[v1].m_connected_vertices, v3);
    
    array_push_unique(m_vertices[v2].m_connected_vertices, v1);
    array_push_unique(m_vertices[v2].m_connected_vertices, v3);
    
    array_push_unique(m_vertices[v3].m_connected_vertices, v1);
    array_push_unique(m_vertices[v3].m_connected_vertices, v2);
    
    if ( v4 != -1 ) {
        array_push_unique(m_vertices[v2].m_connected_vertices, v4);
        array_push_unique(m_vertices[v3].m_connected_vertices, v4);
        array_push_unique(m_vertices[v4].m_connected_vertices, v2);
        array_push_unique(m_vertices[v4].m_connected_vertices, v3);
        
        array_push_unique(m_vertices[v4].m_groups, group );
    }
}


f_set_vertex_data = function(_id, _x, _y, _z, _q) {
    var vertex = m_vertices[_id];
    

    if ( vertex == -1 ) {
        vertex = instance_create_depth(-1, -1, 1, o_vertex);
        m_vertices[_id] = vertex;
        
        vertex.m_id = _id;
        vertex.sprite_index = spr_vertex_groupless;
        
        for ( var i = _id - 1; i >= 0; i-- ) {
            var v = m_vertices[i]; 
            if ( v != -1 && v.m_group != -1 ) {
                vertex.m_group = v.m_group;
            }
        }
    }
    
    vertex.m_x = _x;
    vertex.m_y = _y;
    vertex.m_z = _z;
    vertex.m_q = _q;
  
}

f_create_vertex = function(_filePos, _id, _x, _y, _z, _q) {
    if ( m_vertices[_id] != -1 ) { return; }

    var vertex = instance_create_depth(-1, -1, 1, o_vertex);

    vertex.m_file_position = _filePos;
    
    vertex.m_id = _id;
    vertex.m_x = _x;
    vertex.m_y = _y;
    vertex.m_z = _z;
    vertex.m_q = _q;
    
    m_vertices[_id] = vertex;
}
