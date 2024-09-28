<%@include file="/WEB-INF/view/user/admin/layout/header.jsp" %>

<div class="wraper-content">
    <div class="title-section">
        <h5>Add Menu Item</h5>
        <hr>
    </div>
    <div class="form-content">
        <form>
            <div class="row">
                <div class="col-lg-6">
                    <div class="form-group d-flex justify-content-between">
                        <div class="col-lg-2"><label for="category">Category</label></div>
                        <div class="col-lg-10">
                            <select class="form-control" id="category">
                                <option value="-1">Select Category</option>
                                <option value="1">Appetizer</option>
                                <option value="2">Main Course</option>
                                <option value="2">Dessert</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group d-flex justify-content-between">
                        <div class="col-lg-2"><label for="name">Menu Item</label></div>
                        <div class="col-lg-10"><input type="text" class="form-control"  id="name" placeholder="Enter Menu item Name"/></div>
                    </div>
                    <div class="form-group d-flex justify-content-between">
                        <div class="col-lg-2"><label for="price">Price</label></div>
                        <div class="col-lg-10"><input type="text" class="form-control"  id="price" placeholder="Enter Price"/></div>
                    </div>

                </div>
                <div class="col-lg-6">
                    <div class="form-group d-flex justify-content-between">
                        <div class="col-lg-2"><label for="image">Image</label></div>
                        <div class="col-lg-10"><input type="file" class="form-control"  id="image" placeholder="Select Image"/></div>
                    </div>
                    <div class="form-group d-flex justify-content-between">
                        <div class="col-lg-2"><label for="desc">Description</label></div>
                        <div class="col-lg-10"><textarea type="text" class="form-control"  id="desc" placeholder="Enter Menu Item Description"></textarea></div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12 text-end">
                    <button class="btn btn-default" type="button">Cancel</button>
                    <button class="btn btn-second" type="submit">Save</button>
                </div>
            </div>
        </form>
    </div>
</div>

<%@include file="/WEB-INF/view/user/admin/layout/footer.jsp" %>

</body>
</html>