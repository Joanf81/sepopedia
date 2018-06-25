user = User.create!( 
	:email => 'a@a.a', 
	:password => '123456', 
	:password_confirmation => '123456'
	)
user.webmaster!

User.create!( 
	:email => 'b@b.b', 
	:password => '123456', 
	:password_confirmation => '123456'
)

User.create!( 
	:email => 'c@c.c', 
	:password => '123456', 
	:password_confirmation => '123456'
)