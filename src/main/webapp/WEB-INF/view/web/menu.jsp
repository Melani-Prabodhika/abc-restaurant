<%@include file="/WEB-INF/view/layout/header.jsp" %>

<style>

  /* Menu Section */
  .menu-section {
    padding: 60px 0;
    background-color: #f2f2f2;
    text-align: center;
  }

  .menu-section .menu-title {
    font-size: 36px;
    font-weight: 700;
    color: #000000;
    margin-top: 20px;
    margin-bottom: 20px;
    text-transform: uppercase;
  }

  .menu-categories {
    display: flex;
    justify-content: space-around;
    flex-wrap: wrap;
  }

  .menu-categories .category {
    background-color: #fff;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    padding: 20px;
    margin: 15px;
    border-radius: 4px;
    width: 30%;
    min-width: 250px;
  }

  .menu-categories .category h3 {
    font-size: 24px;
    color: #333;
    font-weight: 600;
    margin-bottom: 20px;
    text-transform: capitalize;
  }

  .menu-categories .category ul {
    list-style: none;
    padding: 0;
  }

  .menu-categories .category ul li {
    font-size: 18px;
    color: #555;
    display: flex;
    justify-content: space-between;
    margin-bottom: 10px;
  }

  .menu-categories .category ul li span {
    font-size: 16px;
    color: #BD965A;
    font-weight: 600;
  }

  .menu-categories .category ul li:hover {
    color: #BD965A;
    transition: color 0.3s ease-in-out;
  }

  .menu-categories .category .menu-image {
    width: 100%;
    height: 250px;
    border-radius: 4px;
    margin-bottom: 15px;
  }

  /* Responsive Design */
  @media (max-width: 768px) {
    .menu-categories {
      flex-direction: column;
      align-items: center;
    }

    .menu-categories .category {
      width: 80%;
      margin-bottom: 30px;
    }
  }

</style>

<!-- Start Menu Section -->
<div class="menu-section" id="menu">
  <div class="container"><br><br><br>
    <h2 class="menu-title">Our Menu</h2>
    <div class="menu-categories">
      <div class="category">
        <h3>Appetizers</h3>
        <ul>
          <li>Spring Rolls <span>LKR 550.00</span></li>
          <li>Chicken Wings <span>LKR 650.00</span></li>
          <li>Garlic Bread <span>LKR 400.00</span></li>
          <li>Bruschetta <span>LKR 500.00</span></li>
          <img src="/assets/img/kegs-pancakes-with-red-fish.jpg" alt="Desserts" class="menu-image">
        </ul>
      </div>
      <div class="category">
        <h3>Main Courses</h3>
        <ul>
          <li>Grilled Steak <span>LKR 1800.00</span></li>
          <li>Pasta Carbonara <span>LKR 1200.00</span></li>
          <li>Chicken Curry <span>LKR 1300.00</span></li>
          <li>Vegetable Stir-Fry <span>LKR 1100.00</span></li>
          <img src="/assets/img/side-view-noodles-with-vegetables-with-corn-cucumber-bell-pepper.jpg" alt="Main Courses" class="menu-image">
        </ul>
      </div>
      <div class="category">
        <h3>Desserts</h3>
        <ul>
          <li>Chocolate Cake <span>LKR 650.00</span></li>
          <li>Cheesecake <span>LKR 700.00</span></li>
          <li>Tiramisu <span>LKR 750.00</span></li>
          <li>Fruit Salad <span>LKR 550.00</span></li>
          <img src="/assets/img/top-view-pancakes-with-fresh-fruits-chocolate-grey.jpg" alt="Desserts" class="menu-image">
        </ul>
      </div>
    </div>
  </div>
</div>
<!-- End Menu Section -->

<%@include file="/WEB-INF/view/layout/footer.jsp" %>

</body>
</html>