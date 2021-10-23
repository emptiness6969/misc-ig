local requestHandler = {}
requestHandler.__index = requestHandler

function requestHandler.new(onErrorCallback, onSuccessCallback)
    local self = setmetatable({}, requestHandler)
    self["onErrorCallback"] = onErrorCallback or nil
    self["onSuccessCallback"] = onSuccessCallback or nil
    return self
end

function requestHandler:CreateRequest(url)
    local response
    local success = pcall(function()
        response = syn.request({
            ["Url"] = url,
            ["Method"] = "GET"
        })
    end)
    
    local responseStatusCode = response.StatusCode

    if (success and responseStatusCode == 200) then
        if (self.onSuccessCallback) then
            return self.onSuccessCallback(responseStatusCode)
        end
    else
        if (self.onErrorCallback) then
            return self.onErrorCallback(responseStatusCode)
        end
    end

    return response
end

return requestHandler
