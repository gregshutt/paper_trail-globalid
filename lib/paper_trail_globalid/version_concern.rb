module PaperTrailGlobalid
  module VersionConcern
    def whodunnit=(value)
      if value.is_a? ActiveRecord::Base
        super(value.to_gid)
      else
        super
      end
    end

    # Returns an object which was responsible for a change
    # you need to store global_id to whodunnit field to make this method return the object(who was responsible)
    # for example, whodunnit => "gid://app/Order/1" then
    # whodunnit_user will return Order.find_by(id: 1) in application scope.
    def actor
      begin
        ::GlobalID::Locator.locate(whodunnit) || whodunnit
      rescue ActiveRecord::RecordNotFound
        nil
      end
    end
  end
end
