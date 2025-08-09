if ( o_vertex_display.m_current_vertex == self.id ) {
    draw_self();
}

else if ( visible ) {
    draw_sprite_ext(sprite_index, image_index, x, y, 1, 1, 0, d_color, 1.0);
 }