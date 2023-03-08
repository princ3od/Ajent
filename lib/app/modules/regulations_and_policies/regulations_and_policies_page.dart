import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RegulationsAndPoliciesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.grey[100],
        toolbarHeight: 70.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "terms_title_label".tr,
          style: GoogleFonts.nunitoSans(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RichText(
            text: TextSpan(
                text: "Article 1. Service description",
                style: GoogleFonts.nunitoSans(
                    color: Colors.black, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                      text:
                          "\n\The Tutor Time application provides include search tools, learning engagement teaching classes in the form of spontaneous classes with the ability to request participation in learning or teaching, allowing users to evaluate the lessons. classes, add classes edit the course content, organize activities by Tutor Time. Allows you to create and join classes, hereinafter referred to as the “Tutor Time App”.",
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.normal, color: Colors.black)),
                  TextSpan(
                      text: "\nArticle 2. Terminology",
                      style:
                          GoogleFonts.nunitoSans(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          "\n1. ““Customer” is a trader, organization or individual wishing to use the Tutor Time App.\n2. “User” means an organization or individual who wishes to find out information and products and services of the Customer. User is required to register an account to become a member of the Client.\n3. “You” includes the user/customer of the Tutor Time.n4 App. “Personal information” means information associated with the identification and identification of an individual, including: name, age, address, identity card number or citizen identification, phone number, address email and other information as required by law.\n5. “State” means Kingdom of Saudi Arabia.\n6. “Private area” is the sales interface page, the content of the management pages.\n7. “Common area” means Tutor Time Home; login screen; footer area, logo on interface pages and Tutor Time App.\n8. “Feature” means a feature currently available and available at Tutor Time.\n9. “App Store” is the Google Play Store application distribution platform.",
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.normal)),
                  TextSpan(
                      text:
                          "\nArticle 3. Regulations on accounts using Tutor Time",
                      style:
                          GoogleFonts.nunitoSans(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          "\n1. Before registering for an account, you confirm that you have read, understood and agreed to all the provisions of this Agreement and the regulations of the service providers with which Tutor Time is affiliated. Refusal to accept the terms of provision and use of this service will mean refusal to use the service.\n2. You understand and agree that Tutor Time will create, issue and verify a digital form (collectively, a “Digital Certificate”) for each user account. This digital certificate is attached to each electronic document and email notification has been accepted. You agree that your Digital Certificate is a valid “Electronic Signature” which replaces your consent in the activities taking place on the Website or the Service and/or the Tutor Time App.\n3 . You commit: \n– Be responsible for your behavioral capacity in registering an account to use the service and commit to ensuring that you are at least 13 years old.\n– Provide complete and accurate information requirements of the account registration form and update this information in accordance with the actual situation.\n– Take full responsibility for all account registration information, information to modify and supplement your Tutor Time account.\n– Do not transfer your account to anyone unless it has been agreed by the Tutor Time service provider. written comments.\n4. You can use your phone number, email or associated account to log in to Tutor Time. You will be responsible for\n– The security of your login account and password.\n– All activities that occur on or through your visitor's account.\n5. To log in to Tutor Time from a linked account, you must complete the registration steps to link your account and accept the terms of use of the affiliate feature with the associated service provider. You acknowledge that you have read, understood and accepted these terms and conditions and risks using this login link feature.\n6. To ensure security – the security of your account, you undertake not to share your password, not to allow others to access your account, or to do anything that might jeopardize the security. of account. In the event that you discover or believe that there is an unauthorized login to your account, you must notify us immediately so that we can work together to prevent loss of information. We reserve the right to limit or suspend account logins at any time if necessary for information security reasons. We cannot and will not be liable for any loss, damage or other liability if you fail to comply with this provision due to unauthorized access to your account.\n7. When you have a user account, you are authorized to access and use the Tutor Time App and operate on the Apps hosted by Tutor Time (“Customer App”). Any content that installs your activity, Tutor Time is not responsible for approving or controlling the content, but you are solely responsible for your use of the service.\n8. You are the person who directly manages and maintains your right to use the services, is solely responsible for the consequences that may arise in case you violate the regulations on using the service, or because caused by lax management.\n 9. You are solely responsible for creating backups and replacements of any Content you post or store on the App at your expense.\n10. Tutor Time Web and App are licensed by the owners of Tutor Time. This license is required to comply with the Terms of this policy.\n11. Tutor Time reserves the right, in its sole discretion, to terminate your account and your access to the Apps, Tutor Time Applications and Services or any part thereof to remove or block access to any App. customer, or any user content at any time. Tutor Time does not bear any responsibility to you for exercising this right of Tutor Time, and Tutor Time will not give notice for each case.\n12. The classes you create may contain notification services, communication areas, newsgroups, forums, communities, personal and commercial websites, calendars, postcards, and/or messaging facilities. information or other means of communication designed to enable you or others to communicate with the public or groups (collectively, the “Interactive Services”), you agree to use the Interactive Services only to notify, send and receive messages in accordance with the Content Policies, Terms and applicable law.\n13. You agree to be responsible for the content and risks with transaction information, content exchanged with others of the Client App.\n14. You agree that no joint venture, partnership, brokerage relationship or any other form of partnership exists between you and Tutor Time.\n15. Tutor Time has the right to agree to support or refuse you to publish applications at Google Play (App Store for short), by agreeing to Tutor Time to support publishing applications, you understand and are responsible for compliance. in accordance with all Google Play policies and regulations, Tutor Time reserves the right, in its sole discretion, to remove or suspend your App activity on a Tutor Time-owned publishing account when there are indications that it violates App Store policies or is likely to affect the operation of other Tutor Time publishers. other applications.\n16. You represent and understand that, by agreeing to Tutor Time to support publishing applications at the App Store, you are agreeing that Tutor Time is not committed to and responsible for the existence of your App at the App Store. App Store, when there is a case of interference by Google Play or Apple App Store such as locking or deleting the publishing account owned by Tutor Time resulting in the loss of the App…\n17. You agree to understand that, by agreeing to Tutor Time to support the publication of the application, you are agreeing that Tutor Time has the full right to use your App image for the purpose of promoting Tutor Time. You also understand that you will not be able to access the publishing account owned by Tutor Time to customize your App-related information without Tutor Time's consent or intervention.\n18 . By owning your own publishing account at the App Store, if you choose to self-publish the app, you are solely responsible for the publishing of the app, as well as your commitment to the App Store's policies. You understand, this publication does not mean owning the App, the service Tutor Time provides is an infrastructure rental service under the SaaS model (Software-as-a-Service). You are still responsible for fulfilling the payment obligations required from fees incurred through actual use of Tutor Time in order to continue using the service.",
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.normal)),
                  TextSpan(
                      text: "\nArticle 4. Commitment when using Tutor Time",
                      style:
                          GoogleFonts.nunitoSans(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          "\nYou undertake not to do the prohibited things when using the Service as below:\n1. Propaganda of war, terrorism; causing enmity and conflict between ethnic groups, ethnicities and religions; against the State, harming national security and social order.\n2. Disclosure of State secrets, military, security, economic, dialogue and other secrets prescribed by law.\n3. Propaganda, incitement to violence, lewdness, debauchery, crime, social evils, superstition, destruction of fine customs and traditions.\n4. Disseminating information that distorts, slanders, insults the reputation of the organization, the honor and dignity of the individual.\n5. Advertising, propagating, trading in prohibited goods and services; Dissemination of journalistic, literary, artistic, and prohibited publications.\n6. Forging organizations and individuals and spreading fake information, untruthful information infringing upon the legitimate rights and interests of organizations and individuals.\n7. Illegally obstructing the lawful supply and access of information, the provision and use and legitimate interests on the internet of organizations and individuals.\n8. Illegally obstructing the operation of the server system, the lawful operation of the service-providing equipment system.\n9. Infiltrating or illegally using passwords or cryptographic keys of organizations or individuals; private information, personal information and internet resources.\n10. Tillegally collect, use, distribute and trade personal information of others; take advantage of loopholes and weaknesses of the information system to collect and exploit personal information.\n11. Creating unauthorized links to legitimate domain names of organizations and individuals; illegally attacking or disabling the information system's network information security measures; create, install, distribute malware, computer viruses; illegally infiltrate, gain control of information systems, create attack tools on the internet.\n12. Conduct fraud or any of the acts specified in Article 4 of this Agreement on the applications of Tutor Time or any third party with which Tutor Time cooperates to support the performance of Tutor Time's services. .\n13. Other prohibitions as prescribed by law",
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.normal)),
                  TextSpan(
                      text: "\Article 5. Rights and obligations of Tutor Time",
                      style:
                          GoogleFonts.nunitoSans(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          "\n1.Tutor Time has the right to request users to remove information that violates the provisions of Article 4 when detecting such information.\n2. reserves the right to immediately terminate or suspend your account, and/or delete your content and/or you report to the authorities with which Tutor Time has/or failed to notify you when you violate any part of this Agreement.\n3. Tutor Time is under no obligation to review any content posted, stored or uploaded by You or other third parties.\n4. Tutor Time is not responsible for the warranties of the content on the App with any user or the agreements, transactions made on the App or in connection with the users of Tutor Time.\n5. Tutor Time reserves the right to remove, monitor or edit any content posted or hosted on Tutor Time's applications at any time and for any reason without notice to you\n6 . Tutor Time reserves the right to terminate your access to any or all of the Tutor Time Services application pages; remove or disable access to any of your applications or contents at any time without notice for any reason or for no reason.\n7. Tutor Time is committed to keeping the information that you provide us or we collect confidential and will not disclose it to any third parties unless requested by a competent State Authority or is necessary. to (a) enforce the Terms of this Agreement, (b) detect, prevent fraud, security, or technical problems, (c) respond to user support requests, or (d) ) protect the rights, property or safety of Tutor Time, its users and the public.\n8. Tutor Time is not responsible in any way for the information you provide to third parties in connection with the Application or the third parties operating the Application, who may use personal information that you give them.\n9. Tutor Time does not control or endorse the content, messages or information found in any Application. Tutor Time has no liability whatsoever for the Applications and any actions resulting from your participation in any of the Applications or your use of the service on other Applications.\n10 . Tutor Time is obligated to provide you with a technical warranty for the duration of your use. Tutor Time does not warrant that the Tutor Time Applications will meet your requirements or that their operations will be uninterrupted or error free.",
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.normal)),
                  TextSpan(
                      text: "\nArticle 6. Links to 3rd parties",
                      style:
                          GoogleFonts.nunitoSans(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          "\n1. Tutor Time's application may link to and contain links to third-party websites, including text links; embedded video; and software applications (Including weather, exchange rate, chat widgets) (collectively, “Linked Sites”).\n2. Linked Sites are the property of their respective third parties and may be protected by/or intellectual property laws and international treaties. This Linked Site content and third party information are beyond the control and/or not owned and managed by Tutor Time. Tutor Time is not responsible for any content of the Linked Site, including risks, economic losses, data loss that may arise from accessing the Linked Site.\n3. The Tutor Time application may rely on third parties to provide or complete some functions. Choosing to use software functions and applications from third parties may cause changes in the structure or interface of the App. The user chooses to use and is responsible for those choices and is responsible for the due process involved with third party providers.",
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.normal)),
                  TextSpan(
                      text: "\nArticle 7. Data use and storage",
                      style:
                          GoogleFonts.nunitoSans(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          "\n1. What is posted to the App may be subject to restrictions on copying, use and/or dissemination. Tutor Time reserves the right to create and/or change usage and storage restrictions at any time with or without notice. It is your responsibility to respect those limits.\n2. You agree that Tutor Time has no responsibility for data loss or failure to store the Content or transmit any content or services maintained by Tutor Time and that you are solely responsible for making backup copies and replacing any content you post or store on the app at your own expense.\n3. Tutor Time technical warranty for you throughout the period of use. You agree that before submitting an App technical support request, you must back up all data at the time of the technical support request.\n4. You agree that the hosting service for Tutor Time applications is shared hosting, which may result in limitations on the speed of access or the amount of access at the same time, and may result in application interruption. Any application that exceeds this limit will be issued a violation warning and recommended to convert the App to a more optimal form of storage.n5. For some data synchronization tasks from 3rd parties outside the Tutor Time system, you understand & agree that Tutor Time is a SaaS rental service system on a shared server, which will have the most speed limits. regulations on data synchronization between systems (whether Tutor Time or those 3rd parties). The data needs to be processed sequentially and within certain limits to ensure the stable operation of the whole system. Tutor Time reserves the right to limit it to the level that Tutor Time's sharing system accepts if the system detects signs of consuming Tutor Time's common system resources (due to a large number of requests from within that system or because your business model). Tutor Time may recommend a higher package upgrade; or deployed on a separate system; or refuse to provide connection services to these 3rd party data systems.",
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.normal)),
                  TextSpan(
                      text: "\nArticle 8. Intellectual property rights",
                      style:
                          GoogleFonts.nunitoSans(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          "\n1. All intellectual property rights existing in the Tutor Time App belong to Mr. Fawaz Mereani or legally licensed to Mr. Fawaz Mereani uses whereby all legal rights are guaranteed. Except with his consent, the User may not use, copy, publish, reproduce, transmit or distribute in any way, any part of the intellectual property rights. intellectual property rights to the products or services described in this agreement.\n2. We reserve all rights, including but not limited to, copyright, trademark, trade secret, trademark and other intellectual property rights in the services on the Tutor Time App. Use of our rights and property requires our prior written permission. We do not grant any other license, express or implied, for you to exercise the above rights, other than expressly granted in writing. And therefore, the User has no right to use our product for commercial purposes without our prior written permission.\n3. The Tutor Time logo in your application is understood to be the trademark identity of Tutor Time, the existence of the Tutor Time logo will ensure that your application will be warranted for the duration of the service. Conversely, when you arbitrarily remove the Tutor Time logo, without our consent, you agree that we are not responsible for your App Store warranty.",
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.normal)),
                  TextSpan(
                      text: "\nArticle 9. Indemnity",
                      style:
                          GoogleFonts.nunitoSans(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          "\n1. In any case, Tutor Time is not responsible for the devices and machines that you use to access our application such as: Access device, transmission device. When using the service, You must equip yourself with necessary machinery and equipment for the login and transmission process and you must bear all responsibilities and costs incurred during use.\n2. Tutor Time will not be liable for any actions or omissions of any third party, including without limitation, your financial institution, any payment system, any service provider third, any telecommunications service provider, Internet access points or data centers or computer equipment or software, any mailing or forwarding service or for any other beyond Tutor Time's control (including but not limited to, fire, flood, other natural disaster, war, riot, strike, civil action or military agency, faulty equipment, virus computer, intrusion or attack by a third party, or interruption of electricity; telecommunications; other utility services).\n3. Tutor Time does not guarantee the exclusion of factors harmful to your use of the service, including but not limited to the following: Intentional infringement and damage from third parties, or Viruses . We do not guarantee the delivery of the service without any malfunction, malfunction or other impact if any.\n4. There may be factors beyond our control that lead to product failure. We will try to fix product defects to bring satisfaction to customers and we are not responsible for supporting or compensating customers for the above risks and damages (if any).\n5. You agree to defend, indemnify and exclude Us from all legal liabilities, proceedings, losses and expenses including but not limited to court fees, attorneys' fees, and consultants' costs in connection with it. dealing with or arising out of your breach in the course of using our product.\n6. Tutor Time will not be responsible when Google Play Store has changes in usage policy that affect your use of the Service such as: App is deleted or suspended.",
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.normal)),
                  TextSpan(
                      text: "\nArticle 10. General Terms",
                      style:
                          GoogleFonts.nunitoSans(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          "\nThe event that any provision of these Terms of Use becomes invalid or unenforceable for any reason shall affect only such invalidated provision and shall not affect the validity of such provision. remaining terms. If there is a discrepancy between these Terms of Use and the Service Agreements, the most recent shall prevail.",
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.normal)),
                ]),
          ),
        ),
      ),
    );
  }
}
