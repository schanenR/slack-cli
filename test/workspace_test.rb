

describe "Workspace class" do

  describe "initialize" do

    it "is an instance of workspace" do
      new_workspace = Workspace.new

      expect(new_workspace).must_be_instance_of Workspace
    end
  end

end