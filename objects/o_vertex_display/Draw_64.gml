draw_text(8, 8, d_mode_text);
draw_text(8, 32, string(m_vc_min ) + " - " + string(m_vc_max) + " / " + string(m_vertex_count));
draw_text(0, 64, $"Group {m_group_current} / {m_group_count}");

if ( m_current_vertex != -1 ) {
    draw_set_halign(fa_right);
    draw_text(window_get_width() - 8, 8, $"{m_current_vertex.m_id} - G{m_current_vertex.m_group}");
    draw_text(window_get_width() - 8, 32, "(" + string(m_current_vertex.m_x) + "," + string(m_current_vertex.m_y) + "," + string(m_current_vertex.m_z) + ","+ string(m_current_vertex.m_q) + ")" );
    draw_set_halign(fa_left);
}