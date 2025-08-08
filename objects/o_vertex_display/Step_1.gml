if (keyboard_check(ord("1")) ){
    m_vc_min = max(0, m_vc_min - 1);
}

if (keyboard_check(ord("2")) ){
    m_vc_min = min(m_vc_max, m_vc_min + 1);
}

if (keyboard_check(ord("3")) ){
    m_vc_max = min(m_vertex_count - 1, m_vc_max - 1);
}

if (keyboard_check(ord("4")) ){
    m_vc_max = max(m_vc_min, m_vc_max + 1);
}

if (keyboard_check_pressed(ord("5")) ){
    m_group_current--;
    if ( m_group_current < -1 ) {
        m_group_current = m_group_count;
    }
}

if (keyboard_check_pressed(ord("6")) ){
    m_group_current++;
    if ( m_group_current > m_group_count ) {
        m_group_current = -1;
    }
}