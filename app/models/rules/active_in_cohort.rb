class Rules::ActiveInCohort < Rule
  def variable_requirement?
    true
  end

  def available_cohorts
    Warehouse::Cohort.active.pluck(:id, :name, :short_name).
      map do |id, name, short_name|
        label = short_name.presence || name
        [id, label]
      end
  end

  def display_for_variable value
    available_cohorts.to_h.try(:[], value.to_i) || value
  end

  def clients_that_fit(scope, requirement)
    if Client.column_names.include?(:enrolled_project_ids.to_s)
      if requirement.positive
        where = 'active_cohort_ids @> ?'
      else
        where = 'not(active_cohort_ids @> ?) OR active_cohort_ids is null'
      end
      scope.where(where, requirement.variable.to_s)
    else
      raise RuleDatabaseStructureMissing.new("clients.active_cohort_ids missing. Cannot check clients against #{self.class}.")
    end
  end
end
