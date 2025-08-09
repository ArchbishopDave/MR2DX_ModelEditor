
if ( o_vertex_display.m_current_vertex == self.id ) {
        for ( var i = 0; i < m_connected_vertices_count; i++ ) {
            var vert = o_vertex_display.m_vertices[m_connected_vertices[i]];
            if ( vert != -1 ) {
                draw_line_width_color(x, y, vert.x, vert.y, 4, c_white, c_yellow);
            }
    }
}

/*else if ( m_id >= o_vertex_display.m_vc_min && m_id <= o_vertex_display.m_vc_max ) {
    draw_sprite_ext(sprite_index, image_index, x, y, 1, 1, 0, d_color, 1.0);
 }*/

else if ( visible ) {
    for ( var i = 0; i < m_connected_vertices_count; i++ ) {
        var vert = o_vertex_display.m_vertices[m_connected_vertices[i]];
        if ( vert != -1 ) {
            draw_line_width_color(x, y, vert.x, vert.y, 2, c_dkgray, c_dkgray);
        }
    }
 }
