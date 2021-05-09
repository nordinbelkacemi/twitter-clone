require "test_helper"

class LikeTest < ActiveSupport::TestCase
  test "Can't create two likes on the same post" do
    like1 = Like.new(user: users(:user1), likeable: posts(:test_post))
    like2 = Like.new(user: users(:user1), likeable: posts(:test_post))

    like1.save
    assert !like2.save, "Shouldn't be able to create two likes on the same post"
  end

  test "Can't create two likes on the same comment" do
    like1 = Like.new(user: users(:user1), likeable: comments(:test_comment))
    like2 = Like.new(user: users(:user1), likeable: comments(:test_comment))

    like1.save
    assert !like2.save, "Shouldn't be able to create two likes on the same comment"
  end
end
