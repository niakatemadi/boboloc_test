Stripe settlements explanations : 

No subscribment : Renter can add just one car.
Silver subscribment : Renter can add until 5 cars.
Gold subscribment : Renter can add illimity cars.

When the renter signIn he is redirected to cars_list_page.
At the bottom of cars_list_page we have a floatButton who allow renters to add a new car.

When the renter click on the floatButton he is redirected according to his current subscribment and his current cars number.

If his current subscribment don't allow him to add a new car he is redirected on a subscribment page with the subscribments who can allow him to add more cars.

For example :

- if he doesn't have any subscribment and he wants to add the second car, he is automaticly redirected to a subscribment with two options : Silver subscribment or Gold subscribment.

- If his current subscribment is silver and he already added 5 cars he is automaticly redirected to subscribment page with 1 option which is gold subscribment.(That happen when he clicks on the floatButton which allow to add a new car)

I already created a function in Database folder called getCarsNumber who return the number of cars of the current user.