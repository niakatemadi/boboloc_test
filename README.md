I need to settle three subscribments package to my flutter firebase mobile application.

Theses 3 packages are :

- Free (can add only 1 car)
- Silver (can add max 5 cars)
- Gold (can add unlimited cars)

What I need is that every customer who sign up can sign in and add just one car by clicking on the floatButton at the bottom of the cars list page(It's the page where cars are listed).

 When a customer want to add car by clicking on the floatbutton at the bottom of "cars_list_page", a function check if his current subscribment allow him to have one more car . If his current subscribment don't allow him to have more cars we have to redirect him to a subscribment page which shows the susbcribments which allows him to add more cars. When he is on subscribment page he should see either one car called gold if his current subscribment is silver or he should see silver and gold card subscribment if he doesn't have any subscribment. Here he should be able to subscribe and when he subscribe to silver or gold he should be able to add the number of cars allowed by the subscribment he choosed

- Also We need to create a new button in profile page which redirect to a page which allow customers to manage their subscribments. They can upgrade their subscribments, cancel and unsubscribe.

- If the customer subscribment allow him to add a new car he is redirected to a page which allows him to create a new car when he clicks on the floatbutton at the bottom of "cars_list_page".


- These subscribments should renew automatically and settled up with stripe