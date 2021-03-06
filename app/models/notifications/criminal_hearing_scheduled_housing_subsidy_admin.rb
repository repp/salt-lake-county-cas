module Notifications
  class CriminalHearingScheduledHousingSubsidyAdmin < Base
    
    def self.create_for_match! match
      match.housing_subsidy_admin_contacts.each do |contact|
        create! match: match, recipient: contact
      end
    end

    def event_label
      label = _('Housing Subsidy Administrator')
      label += ' '
      label += _('sent notice of criminal background hearing date.')
    end

  end
end
