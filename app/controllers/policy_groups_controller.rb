class PolicyGroupsController < PublicFacingController
  def index
    @policy_groups = PolicyGroup.order(:name)
  end
end
