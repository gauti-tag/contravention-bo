module ViewsHelper

  def format_number(value)
    number_to_human(value, units: {thousand: "k", million: "m", billion: "M"})
  end

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
      %Q[<input checked="checked" id="admin_profile_admin_ability_ids_#{id}" name="admin_profile[admin_ability_ids][]" type="checkbox" value="#{id}" class="form-check-input" />].html_safe
    else
      %Q[<input id="admin_profile_admin_ability_ids_#{id}" name="admin_profile[admin_ability_ids][]" type="checkbox" value="#{id}" class="form-check-input" />].html_safe
    end
  end

  def display_user_status(user_status)
    status_class = user_status.eql?('active') ? 'text-success' : 'text-danger'
    %Q(<span class="fw-bold #{status_class}">#{user_status_label(user_status)}</span>)
  end

  def select_mulitple_tag(name, values)
    options = ''
    values.each do |value|
      options << %Q(<option value="#{value.first}">#{value.last}</option>)
    end
    %Q(<select id='choices-multiple' required class='choices-multiple w-100 mb-0' name="#{name}" multiple='multiple'>#{options}</select>)
  end

  def display_log_tag(tag)
    tag_class ="badge bg-primary"
    case tag
    when "INFO"
      tag_class ="badge bg-info"
    when "WARN"
      tag_class ="badge bg-warning"
    when "ERROR"
      tag_class ="badge bg-danger"
    end
    %Q[<span class="#{tag_class}">#{tag}</span>]
  end


  def display_bet_status(status)
    status_class ="badge bg-primary"
    case status
    when "pending"
      status_class ="badge bg-info"
    when "winning"
      status_class ="badge bg-warning"
    when 'success'
      status_class ="badge bg-success"
    when 'failure', 'losing'
      status_class ="badge bg-danger"
    end
    %Q[<span class="#{status_class}">#{user_status_label(status)}</span>]
  end

  def user_status_label(status)
    {
      'suspended' => 'Suspendu',
      'active' => 'Actif',
      'pending' => 'En atente',
      'winning' => 'Gagnant',
      'losing' => 'Perdant',
      'success' => 'Validé',
      'failure' => 'Échèc'
    }.fetch(status, '')
  end 

  def display_wallet(wallet)
    {
        'mtn_guinee' => 'Mtn',
        'orange_guinee' => 'Orange'
    }.fetch(wallet)
  end

  def mois(mois)
    {
         '1' => 'Janvier',
         '2' => 'Février',
         '3' => 'Mars',
         '4' => 'Avril',
         '5' => 'Mai',
         '6' => 'Juin',
         '7' => 'Juillet',
         '8' => 'Août',
         '9' => 'Septembre',
         '10' => 'Octobre',
         '11' => 'Novembre',
         '12' => 'Décembre'
    }.fetch(mois, '')
  end

  
  
end