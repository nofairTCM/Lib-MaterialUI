local MaterialUI = require(game:GetService("ReplicatedStorage"):WaitForChild("nofairTCM_Client"):WaitForChild("MaterialUI"));
local new = MaterialUI.Create;

local TextBox,Output

local startKList = {'ㄱ', 'ㄲ', 'ㄴ', 'ㄷ', 'ㄸ', 'ㄹ', 'ㅁ', 'ㅂ', 'ㅃ', 'ㅅ', 'ㅆ', 'ㅇ', 'ㅈ', 'ㅉ', 'ㅊ', 'ㅋ', 'ㅌ', 'ㅍ', 'ㅎ'};
local midKList = {'ㅏ', 'ㅐ', 'ㅑ', 'ㅒ', 'ㅓ', 'ㅔ', 'ㅕ', 'ㅖ', 'ㅗ', 'ㅘ', 'ㅙ', 'ㅚ', 'ㅛ', 'ㅜ', 'ㅝ', 'ㅞ', 'ㅟ', 'ㅠ', 'ㅡ', 'ㅢ', 'ㅣ'};
local endKList = {'', 'ㄱ', 'ㄲ', 'ㄳ', 'ㄴ', 'ㄵ', 'ㄶ', 'ㄷ', 'ㄹ', 'ㄺ', 'ㄻ', 'ㄼ', 'ㄽ', 'ㄾ', 'ㄿ', 'ㅀ', 'ㅁ', 'ㅂ', 'ㅄ', 'ㅅ', 'ㅆ', 'ㅇ', 'ㅈ', 'ㅊ', 'ㅋ', 'ㅌ', 'ㅍ', 'ㅎ'};
local function decodeKoreanStr(str)
    local returnStr = ""
    for _,code in utf8.codes(str) do -- 글자 utf 에서 코드를 가져옴
        if code >= 44032 and code <= 55199 then -- 한국어임
            local kcode = code - 44032; -- 한국어 시작점인 44032 를 뺀값

            local startK = math.floor(kcode / 588) -- 초성 인덱스
            local midK = math.floor((kcode - (startK * 588)) / 28) -- 중성 인덱스
            local endK = math.floor((kcode - (startK * 588) - (midK * 28))) -- 종성 인덱스

            returnStr = returnStr .. startKList[startK+1] .. midKList[midK+1] .. endKList[endK+1]
        else -- 한국어가 아님
            returnStr = returnStr .. utf8.char(code)
        end
    end
    return returnStr;
end

new("Frame",{
    Parent = script.Parent;
    Size = UDim2.fromOffset(320,280);
    Position = UDim2.fromScale(0.5,0.5);
    AnchorPoint = Vector2.new(0.5,0.5);
    BackgroundColor3 = MaterialUI:GetColor("Background");
},{
    Shadow = new("Shadow");
    Text = new("TextLabel",{
        TextColor3 = MaterialUI:GetColor("TextColor");
        Text = "한글 분해 알고리즘";
        Size = UDim2.new(1,0,0,54);
        BackgroundTransparency = 1;
        TextXAlignment = Enum.TextXAlignment.Left;
        TextSize = 16;
        Position = UDim2.fromOffset(12,0);
    });
    TextBox = new("TextField",{
        WhenCreated = function (this)
            TextBox = this;
        end,
        Size = UDim2.new(1,-42,0,38);
        Position = UDim2.new(0.5,0,0,58);
        AnchorPoint = Vector2.new(0.5,0);
        PlaceholderText = "분해할 한글";
        Text = "한글을 분해해 봅시다 abcd";
        TextSize = 14;
    });
    Run = new("Button",{
        Size = UDim2.new(0,72,0,34);
        Position = UDim2.new(0.5,0,0,114);
        AnchorPoint = Vector2.new(0.5,0);
        Text = "분해하기";
        MouseButton1Click = function (this)
            Output.Text = decodeKoreanStr(TextBox.Text);
        end,
    });
    Output = new("TextLabel",{
        WhenCreated = function (this)
            Output = this;
        end;
        TextColor3 = MaterialUI:GetColor("TextColor");
        TextWrapped = true;
        Size = UDim2.new(1,-42,1,-170);
        Position = UDim2.new(0.5,0,0,158);
        AnchorPoint = Vector2.new(0.5,0);
        BackgroundTransparency = 0.975;
        BackgroundColor3 = MaterialUI:GetColor("TextColor");
        TextSize = 14;
    });
})
