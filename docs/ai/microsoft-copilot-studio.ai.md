---
title: Microsoft Copilot Studio
description: Build custom copilots - conversational AI, Power Platform integration, no-code/low-code agents, enterprise deployment
---

# :fontawesome-brands-microsoft: Microsoft Copilot Studio

Microsoft's platform for building custom copilots and conversational AI agents. Low-code/no-code builder with Power Platform integration. Create chatbots for websites, Teams, Dynamics. Extends Microsoft 365 Copilot with custom plugins. GPT-4 powered conversations.

!!! tip "2026 Update"
    Generative AI actions powered by Azure OpenAI. Custom plugins for Microsoft 365 Copilot. Dataverse integration for enterprise data. Multi-language support (50+ languages). Voice-enabled copilots. Analytics dashboard for conversation insights.

______________________________________________________________________

## :fontawesome-solid-bolt-lightning: Quick Hits

=== ":fontawesome-solid-list-check: Essential Concepts"

    ```yaml
    # Copilot Studio Components
    Topics:           # Conversation flows (like intents)
      - Trigger phrases  # User inputs that start topic
      - Questions        # Collect information from user
      - Messages         # Responses to user
      - Conditions       # Branching logic
      - Actions          # Call APIs, Power Automate flows

    Entities:         # Structured data extraction
      - Prebuilt       # Date, number, email, etc.
      - Custom         # Company-specific terms

    Variables:        # Store conversation state
      - Topic scope    # Available in current topic
      - Global scope   # Available across all topics

    Generative AI:    # GPT-4 powered responses
      - Boosted conversations  # LLM fallback
      - Generative answers     # Dynamic responses
      - Content moderation     # Safety filters
    ```

    **No-Code Bot Builder:**
    1. Create topics (conversation flows) in visual designer
    2. Add trigger phrases ("I need help with...", "How do I...")
    3. Design conversation with questions, messages, conditions
    4. Call Power Automate flows for business logic
    5. Test in webchat, deploy to channels (Teams, website, etc.)

    ```powershell
    # PowerShell Management (for automation)
    Install-Module -Name Microsoft.PowerApps.Administration.PowerShell

    # Connect
    Add-PowerAppsAccount

    # List copilots
    Get-AdminPowerAppChatBot

    # Export copilot
    Export-PowerAppChatBot -ChatBotName "My Copilot" -Path "./export.zip"

    # Import copilot
    Import-PowerAppChatBot -Path "./export.zip" -Environment "prod-env"  # (1)!
    ```

    1. ALM (Application Lifecycle Management) via PowerShell

    **Real talk:**

    - Visual designer means non-developers can build bots
    - GPT-4 integration makes bots smarter (fallback for unhandled queries)
    - Power Platform integration connects to enterprise data
    - Free tier: 10 messages/user/month (limited but usable for testing)
    - Enterprise tier: Pay per conversation (starts $200/tenant/month)

=== ":fontawesome-solid-bolt: Common Patterns"

    ```yaml
    # Topic definition (HR Benefits copilot)
    Topic: Check PTO Balance
    Trigger phrases:
      - "How much PTO do I have?"
      - "Check my vacation days"
      - "Time off balance"

    Flow:
      1. Message: "I'll check your PTO balance."

      2. Action: Call Power Automate flow  # (1)!
         - Input: User.Email (system variable)
         - Output: PTODays, PTOHours

      3. Condition: If PTODays > 10
         - Message: "You have {PTODays} days ({PTOHours} hours) of PTO available. Great! You have plenty saved up."
         Else:
         - Message: "You have {PTODays} days ({PTOHours} hours) of PTO available. Consider planning time off soon."

      4. Question: "Would you like to submit a time-off request?"
         - Yes: Redirect to "Submit PTO Request" topic
         - No: End conversation
    ```

    1. Power Automate flow queries HR system (Workday, SAP, etc.)

    ```yaml
    # Generative AI configuration
    Generative AI Settings:
      Boosted Conversations:
        - Enabled: true  # (1)!
        - Content sources:
            - SharePoint site: "https://contoso.sharepoint.com/sites/hr"
            - Website: "https://contoso.com/policies"
            - Upload documents: "employee-handbook.pdf"
        - Moderation: Medium  # (2)!

      Fallback Topic:
        - If no topic matches: Use generative answers
        - How do you want copilot to respond:
            "Be helpful, professional, and concise. Use information from provided sources. If unsure, say so."
    ```

    1. Generative answers use GPT-4 with your content as grounding
    2. Moderation levels: Low, Medium, High (content filtering)

    ```javascript
    // Custom Web Chat Embedding
    <div id="webchat" role="main"></div>
    <script src="https://cdn.botframework.com/botframework-webchat/latest/webchat.js"></script>
    <script>
      const styleOptions = {
        botAvatarImage: '/bot-avatar.png',
        botAvatarInitials: 'CB',
        userAvatarImage: '/user-avatar.png',
        primaryFont: 'Segoe UI, sans-serif',
        bubbleBackground: '#0078d4',
        bubbleFromUserBackground: '#e5e5e5'
      };  // (1)!

      const directLine = window.WebChat.createDirectLine({
        token: 'YOUR_DIRECT_LINE_TOKEN'  // (2)!
      });

      window.WebChat.renderWebChat(
        {
          directLine: directLine,
          styleOptions: styleOptions
        },
        document.getElementById('webchat')
      );  // (3)!
    </script>
    ```

    1. Customize chat widget appearance (colors, fonts, avatars)
    2. Generate token in Copilot Studio portal (Channels → Web)
    3. Embeds chat widget in any webpage

    ```csharp
    // Custom connector for backend integration
    // 1. Create OpenAPI/Swagger definition
    // 2. Import to Copilot Studio as custom connector
    // 3. Use in Power Automate flow

    // Example: Custom API endpoint
    [HttpPost]
    [Route("api/employee/pto")]
    public async Task<IActionResult> GetPTOBalance([FromBody] PTORequest request)
    {
        var employee = await _hrService.GetEmployeeByEmail(request.Email);
        var ptoBalance = await _hrService.GetPTOBalance(employee.Id);

        return Ok(new {
            Days = ptoBalance.DaysRemaining,
            Hours = ptoBalance.HoursRemaining,
            AccrualRate = ptoBalance.MonthlyAccrual
        });  // (1)!
    }

    // Copilot Studio calls this via Power Automate custom connector
    ```

    1. API returns JSON, Power Automate maps to copilot variables

    ```yaml
    # Microsoft 365 Copilot Plugin (Declarative Agent)
    # copilot-extensions.json
    {
      "manifestVersion": "1.0",
      "id": "com.contoso.hr-copilot",
      "name": "HR Assistant",
      "description": "Check PTO, submit requests, view benefits",
      "instructions": "Help employees with HR-related questions. Be professional and accurate.",
      "capabilities": [
        {
          "name": "CheckPTO",
          "description": "Check employee PTO balance",
          "type": "action"  # (1)!
        }
      ],
      "dataSources": [
        {
          "type": "sharepoint",
          "siteUrl": "https://contoso.sharepoint.com/sites/hr"
        }
      ]
    }
    ```

    1. Extends Microsoft 365 Copilot with custom skills

    **Why this works:**

    - Visual designer lowers barrier to entry (no coding required)
    - Power Automate integration connects to 400+ services
    - Generative AI handles unexpected questions
    - Teams integration provides instant user base
    - ALM via solutions (export/import between environments)

=== ":fontawesome-solid-fire: Pro Tips & Gotchas"

    !!! success "Best Practices"
        - **Start simple** - Begin with 5-10 topics, add complexity gradually
        - **Trigger phrases** - Use 5-10 variations per topic (improves matching)
        - **Generative AI** - Enable boosted conversations (better fallback)
        - **Content sources** - Add SharePoint, docs for grounding
        - **Variables** - Use global variables for user context (name, email, dept)
        - **Analytics** - Monitor topic usage, abandonment rates
        - **Testing** - Use Test bot feature extensively before deployment

    !!! warning "Security"
        - **Authentication** - Enable for accessing sensitive data
        - **Data Loss Prevention** - Configure DLP policies (Power Platform)
        - **Content moderation** - Enable for user-generated content
        - **API permissions** - Least privilege for custom connectors
        - **Audit logs** - Enable for compliance tracking

    !!! tip "Performance"
        - **Topic design** - Keep conversations under 10 turns (shorter is better)
        - **Variables** - Minimize global variables (memory overhead)
        - **Generative AI** - Cache frequently asked questions as topics
        - **Power Automate** - Optimize flow performance (avoid loops)

    !!! danger "Gotchas"
        - **Licensing** - Free tier very limited (10 messages/user/month)
        - **Capacity** - Enterprise requires Power Apps/Automate licenses
        - **Message definition** - "Message" = one bot response (multi-turn = multiple messages)
        - **Generative AI costs** - Separate Azure OpenAI charges
        - **Topics vs Generative** - Topics always win (can override AI responses)
        - **Entities** - Limited to 50 custom entities per copilot
        - **File uploads** - Not supported in all channels (Teams yes, web varies)
        - **Voice** - Requires additional telephony integration

______________________________________________________________________

## :fontawesome-solid-graduation-cap: Learning Resources

### :fontawesome-solid-book-open: Official Docs

- **[Copilot Studio Documentation](https://learn.microsoft.com/microsoft-copilot-studio/)** - Complete guide
- **[Power Platform Documentation](https://learn.microsoft.com/power-platform/)** - Integration reference
- **[Copilot Studio Community](https://powerusers.microsoft.com/t5/Microsoft-Copilot-Studio/ct-p/PVACommunity)** - Forums and examples

### :fontawesome-solid-rocket: Key Features

- **Visual topic designer** - No-code conversation flows
- **Generative AI** - GPT-4 powered fallback responses
- **Power Platform integration** - Connect to 400+ services
- **Multi-channel** - Deploy to Teams, web, Facebook, Slack
- **Analytics** - Conversation insights, topic performance
- **Microsoft 365 Copilot plugins** - Extend enterprise copilot

______________________________________________________________________

## :fontawesome-solid-star: Deployment Channels

| Channel | Setup Complexity | Features | Use Case |
|---------|-----------------|----------|----------|
| Microsoft Teams | Easy | Rich cards, adaptive cards, tabs | Internal employees |
| Website | Easy | Customizable widget | Customer support |
| Facebook Messenger | Medium | Rich media, quick replies | Social engagement |
| Slack | Medium | Slash commands, interactive buttons | External collaboration |
| Dynamics 365 | Easy | CRM integration | Sales, service teams |
| Azure Bot Service | Advanced | Custom channels, speech | Enterprise scenarios |

______________________________________________________________________

## :fontawesome-solid-dollar-sign: Pricing (2026)

| Tier | Price | Messages Included | Best For |
|------|-------|-------------------|----------|
| Free | $0 | 10 messages/user/month | Testing, demos |
| Paid | $200/tenant/month | 2,000 messages/month | Small teams |
| Enterprise | Custom | Unlimited | Large organizations |

**Overage:** $0.30 per conversation (after included messages)

**Additional Costs:**
- Azure OpenAI (Generative AI): ~$0.002 per conversation
- Power Automate flows: Included in premium licenses
- Premium connectors: Varies by service

______________________________________________________________________

## :fontawesome-solid-star: Integration Points

- **Power Automate** - Business logic, API calls, data operations
- **Power Apps** - Launch apps from copilot conversations
- **Dataverse** - Enterprise data storage and retrieval
- **SharePoint** - Document search and retrieval
- **Dynamics 365** - CRM/ERP integration
- **Azure OpenAI** - Generative AI capabilities
- **Microsoft 365 Copilot** - Extend with custom plugins

______________________________________________________________________

**Last Updated:** 2026-02-02 | **Vibe Check:** :fontawesome-solid-users: **Low-Code Champion** - Perfect for business users building conversational AI. Visual designer is intuitive. Power Platform integration is powerful. Licensing confusing. Great for internal use cases (Teams). Generative AI makes bots smarter.

**Tags:** copilot-studio, microsoft, conversational-ai, chatbots, low-code
