<%@include file="/WEB-INF/view/user/admin/layout/header.jsp" %>

<div class="wraper-content">
    <div class="title-section">
        <h5>Add Staff</h5>
        <hr>
    </div>
    <div class="form-content">
        <form>
            <div class="row">
                <div class="col-lg-6">
                    <div class="form-group d-flex justify-content-between">
                        <div class="col-lg-2"><label for="">User Type</label></div>
                        <div class="col-lg-10">
                            <select class="form-control"  id="">
                                <option value="-1">Select User Type</option>
                                <option value="1">Admin</option>
                                <option value="2">Staff</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group d-flex justify-content-between">
                        <div class="col-lg-2"><label for="name">Name</label></div>
                        <div class="col-lg-10"><input type="text" class="form-control"  id="name" placeholder="Enter Name"/></div>
                    </div>
                    <div class="form-group d-flex justify-content-between">
                        <div class="col-lg-2"><label for="phone">Contact No</label></div>
                        <div class="col-lg-10"><input type="text" class="form-control"  id="phone" placeholder="Enter Contact No"/></div>
                    </div>
                    <div class="form-group d-flex justify-content-between">
                        <div class="col-lg-2"><label for="password">Password</label></div>
                        <div class="col-lg-10"><input type="text" class="form-control"  id="password" placeholder="Enter Password"/></div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="form-group d-flex justify-content-between">
                        <div class="col-lg-2"><label for="branch">Branch</label></div>
                        <div class="col-lg-10">
                            <select class="form-control"  id="branch">
                                <option value="-1">Select Branch</option>
                                <option value="1">Colombo</option>
                                <option value="2">Kandy</option>
                                <option value="3">Galle</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group d-flex justify-content-between">
                        <div class="col-lg-2"><label for="email">Email</label></div>
                        <div class="col-lg-10"><input type="email" class="form-control"  id="email" placeholder="Enter Email Address"/></div>
                    </div>
                    <div class="form-group d-flex justify-content-between">
                        <div class="col-lg-2"><label for="address">Address</label></div>
                        <div class="col-lg-10"><textarea type="text" class="form-control"  id="address" placeholder="Enter Address"></textarea></div>
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