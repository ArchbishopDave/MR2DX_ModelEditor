
if ( o_vertex_display.m_current_vertex == self.id ) {
        for ( var i = 0; i < m_connected_vertices_count; i++ ) {
            var vert = o_vertex_display.m_vertices[m_connected_vertices[i]];
            if ( vert != -1 ) {
                draw_line_width_color(x, y, vert.x, vert.y, 2, c_white, c_yellow);
            }
    }
}

/*else if ( m_id >= o_vertex_display.m_vc_min && m_id <= o_vertex_display.m_vc_max ) {
    draw_sprite_ext(sprite_index, image_index, x, y, 1, 1, 0, d_color, 1.0);
 }*/

else if ( o_vertex_display.m_group_current == -1 || o_vertex_display.m_group_current == m_group ) {
    for ( var i = 0; i < m_connected_vertices_count; i++ ) {
        var vert = o_vertex_display.m_vertices[m_connected_vertices[i]];
        if ( vert != -1 ) {
            draw_line_width_color(x, y, vert.x, vert.y, 1, c_dkgray, c_dkgray);
        }
    }
 }
