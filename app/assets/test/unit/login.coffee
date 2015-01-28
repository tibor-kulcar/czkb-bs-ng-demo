service = null
$httpBackend = null

describe "login service test", () ->
    beforeEach module 'app'

    beforeEach inject (User, _$httpBackend_) ->
        service = User
        $httpBackend = _$httpBackend_

    it "Ensure login works", () ->
        #User is not logged in
        expect(service.isLogged()).toBe(false)

        #First expect login request
        $httpBackend.expectPOST('/api/session', {
            username: 'Franta'
        }).respond({})

        #Then expect get index.html
        $httpBackend.expectGET('templates/index.html').respond({})

        service.login('Franta')

        $httpBackend.flush()

        #User is logged in
        expect(service.isLogged()).toBe(true)

    it "Ensure logout works", () ->
        #User is not logged in
        expect(service.isLogged()).toBe(false)
        #First expect login request
        $httpBackend.expectPOST('/api/session', {
            username: 'Franta'
        }).respond({})
        $httpBackend.expectDELETE('/api/session').respond({})
        $httpBackend.expectGET('templates/index.html').respond({})

        service.login('Franta')
        service.logout()

        $httpBackend.flush()
