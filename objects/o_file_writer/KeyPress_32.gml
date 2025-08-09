/*var buffer = buffer_create(o_vertex_display.m_vertex_count * 8, buffer_fixed, 2);

buffer_seek(buffer, 0, 0);
for ( var i = 0; i < o_vertex_display.m_vertex_count; i++ ) {
    var vertex = o_vertex_display.m_vertices[i];
    buffer_write(buffer, buffer_s16, vertex.m_x);
    buffer_write(buffer, buffer_s16, vertex.m_y);
    buffer_write(buffer, buffer_s16, vertex.m_z);
    buffer_write(buffer, buffer_s16, vertex.m_q);
}

buffer_save(buffer, o_file_parser.m_filename + "OUTPUT");*/

var buffer = buffer_load(o_file_parser.m_filename);
buffer_seek(buffer, buffer_seek_start, o_file_parser.m_tmd_vertex_position);

for ( var i = 0; i < o_vertex_display.m_vertex_count; i++ ) {
    var vertex = o_vertex_display.m_vertices[i];
    
    if ( vertex != -1 ) {
        buffer_seek(buffer, buffer_seek_start, vertex.m_file_position);
        buffer_write(buffer, buffer_s16, vertex.m_x);
        buffer_write(buffer, buffer_s16, vertex.m_y);
        buffer_write(buffer, buffer_s16, vertex.m_z);
        buffer_write(buffer, buffer_s16, vertex.m_q);
  }
    
    else { 
        buffer_seek(buffer, buffer_seek_relative, 8);
    }
}

buffer_save(buffer, o_file_parser.m_filename);