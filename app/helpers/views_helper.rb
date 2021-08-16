module ViewsHelper

  def user_avatar(user)
    (user.avatar.variant(resize: "100x100") rescue '/assets/user.png')
  end
  
  def display_status_link(user_status)
    label = 'Suspendre'
    svg_class ='text-danger'
    svg_path = %Q[M19.5 15c-2.483 0-4.5 2.015-4.5 4.5s2.017 4.5 4.5 4.5 4.5-2.015 4.5-4.5-2.017-4.5-4.5-4.5zm2.5 5h-5v-1h5v1zm-7.18 4h-14.815l-.005-1.241c0-2.52.199-3.975 3.178-4.663 3.365-.777 6.688-1.473 5.09-4.418-4.733-8.729-1.35-13.678 3.732-13.678 6.751 0 7.506 7.595 3.64 13.679-1.292 2.031-2.64 3.63-2.64 5.821 0 1.747.696 3.331 1.82 4.5z]

    if user_status.eql?('suspended')
      label = 'Activer'
      svg_class = 'text-success'
      svg_path = %Q[M19.5 15c-2.483 0-4.5 2.015-4.5 4.5s2.017 4.5 4.5 4.5 4.5-2.015 4.5-4.5-2.017-4.5-4.5-4.5zm2.5 5h-2v2h-1v-2h-2v-1h2v-2h1v2h2v1zm-7.18 4h-14.815l-.005-1.241c0-2.52.199-3.975 3.178-4.663 3.365-.777 6.688-1.473 5.09-4.418-4.733-8.729-1.35-13.678 3.732-13.678 6.751 0 7.506 7.595 3.64 13.679-1.292 2.031-2.64 3.63-2.64 5.821 0 1.747.696 3.331 1.82 4.5z]
    end

    return %Q[<svg class="dropdown-icon #{svg_class} me-2" fill="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="#{svg_path}"></path></svg> #{label}]

  end

  def ability_checkbox(abilities, id)
    if abilities.include?(id)
      %Q[<input checked="checked" id="admin_ability_ids[]" name="admin_ability_ids[]" type="checkbox" value="#{id}" class="form-check-input" />].html_safe
    else
      %Q[<input id="admin_ability_ids[]" name="admin_ability_ids[]" type="checkbox" value="#{id}" class="form-check-input" />].html_safe
    end
  end

  def display_user_status(user_status)
    status_class = user_status.eql?('active') ? "text-success" : "text-danger"
    %Q[<span class="fw-bold #{status_class}">#{user_status_label(user_status)}</span>]
  end

  def user_status_label(status)
    {
      'suspended' => 'Suspendu',
      'active' => 'Actif',
      'pending' => 'En atente'
    }.fetch(status, '')
  end
end