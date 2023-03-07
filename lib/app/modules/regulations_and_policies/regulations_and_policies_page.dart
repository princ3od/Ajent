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
                text: "Cooming Soon!",
                style: GoogleFonts.nunitoSans(
                    color: Colors.black, fontWeight: FontWeight.bold),
                children: [
                  /* TextSpan(
                      text:
                          "\n\tỨng dụng Tutor Time cung cấp bao gồm các công cụ tìm kiếm , tham gia học tập giảng dạy các lớp học dưới dạng các lớp học tự phát có khả năng yêu cầu tham gia học tập hay giảng dạy, cho phép người dùng đánh giá các lớp học, thêm lớp học chỉnh sửa các nội dung khóa học, tổ chức hoạt động bởi Tutor Time. Cho phép bạn tạo và tham gia các lớp học, sau đây gọi tắt là “Ứng dụng Ajent”.",
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.normal, color: Colors.black)),
                  TextSpan(
                      text: "\nĐiều 2. Thuật ngữ",
                      style:
                          GoogleFonts.nunitoSans(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          "\n1. “Khách hàng” là thương nhân, tổ chức, cá nhân có nhu cầu sử dụng Ứng dụng Tutor Time.\n2. “Người dùng” là tổ chức, cá nhân có nhu cầu tìm hiểu thông tin và sản phẩm dịch vụ của Khách hàng. Người dùng bắt buộc phải đăng ký tài khoản để trở thành thành viên của Khách hàng.\n3. “Bạn” bao gồm người dùng / khách hàng của Ứng dụng Tutor Time.n4. “Thông tin cá nhân” là thông tin gắn liền với việc xác định danh tính, nhân thân của cá nhân bao gồm: tên, tuổi, địa chỉ, số chứng minh nhân dân hoặc căn cước công dân, số điện thoại, địa chỉ thư điện tử và thông tin khác theo quy định của pháp luật.\n5. “Nhà nước” là Nhà nước Cộng hòa xã hội chủ nghĩa Việt Nam.\n6. “Khu vực riêng” là Trang giao diện bán hàng, phần nội dung các trang quản lý.\n7. “Khu vực chung” là Trang chủ Ajent.vn; màn hình đăng nhập; khu vực footer, logo tại các trang trên giao diện Web và Ứng dụng Ajent.\n8. “Tính năng” là tính năng hiện có và đang được cung cấp tại Ajent.\n9. “Cửa hàng ứng dụng” là nền tảng phân phối ứng dụng Google CH Play.",
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.normal)),
                  TextSpan(
                      text: "\nĐiều 3. Quy định tài khoản sử dụng Tutor Time",
                      style:
                          GoogleFonts.nunitoSans(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          "\n1. Trước khi đăng ký tài khoản, bạn xác nhận đã đọc, hiểu và đồng ý với tất cả các quy định tại Thỏa thuận này và các quy định của đơn vị cung cấp dịch vụ mà Tutor Time có liên kết. Việc từ chối chấp nhận quy định về cung cấp và sử dụng dịch vụ này sẽ đồng nghĩa với việc từ chối sử dụng dịch vụ.\n2. Bạn hiểu và đồng ý rằng Ajent sẽ tạo ra, phát hành và xác minh một dạng kỹ thuật số (gọi chung là “Chứng thư số”) cho mỗi tài khoản sử dụng. Chứng thư số này được gắn vào mỗi tài liệu điện tử và thông báo bằng email đã được chấp nhận. Bạn đồng ý rằng Chứng thư số của bạn là “Chữ ký điện tử” hợp lệ mà nó thay thế cho sự đồng ý của bạn trong các hoạt động diễn ra trên Trang Web hoặc Dịch vụ và / hoặc Ứng dụng Ajent.\n3. Bạn cam kết:\n– Chịu trách nhiệm về năng lực hành vi trong việc đăng ký tài khoản sử dụng dịch vụ và cam kết đảm bảo từ đủ 13 tuổi trở lên.\n– Cung cấp đầy đủ, chính xác các thông tin yêu cầu của mẫu đăng ký tài khoản và cập nhật các thông tin này phù hợp với tình hình thực tế.\n– Chịu trách nhiệm hoàn toàn trước mọi thông tin đăng ký tài khoản, thông tin sửa đổi, bổ sung tài khoản Ajent.\n– Không chuyển nhượng tài khoản cho bất kỳ ai trừ khi đã được bên cung cấp dịch vụ Ajent đồng ý bằng văn bản.\n4. Bạn có thể dùng số điện thoại, email hoặc tài khoản liên kết để đăng nhập vào Ajent. Bạn sẽ chịu trách nhiệm trong việc\n– Bảo mật về tài khoản, mật khẩu truy cập của bạn.\n– Tất cả các hoạt động xảy ra trên hoặc thông qua tài khoản của truy cập của bạn.\n5. Để đăng nhập Ajent từ tài khoản liên kết, bạn phải thực hiện các bước đăng ký liên kết tài khoản và chấp nhận các quy định về sử dụng tính năng liên kết với bên cung cấp dịch vụ liên kết. Bạn khẳng định đã đọc, hiểu rõ khi chấp nhận những quy định đó cũng như rủi ro về sử dụng tính năng liên kết đăng nhập này.\n6. Để đảm bảo an ninh – bảo mật đối với tài khoản của bạn, bạn cam kết không chia sẻ mật khẩu, không cho người khác truy cập vào tài khoản của bạn hoặc làm bất kỳ điều gì có thể gây nguy hiểm cho sự bảo mật của tài khoản. Trong trường hợp phát hiện ra hoặc cho là đang có sự đăng nhập trái phép vào tài khoản của bạn, bạn phải thông báo cho chúng tôi ngay lập tức để cùng phối hợp xử lý tránh mất mát thông tin. Chúng tôi có quyền hạn chế hoặc đình chỉ việc đăng nhập tài khoản bất cứ lúc nào nếu cần thiết vì lý do bảo mật thông tin. Chúng tôi không thể và sẽ không chịu trách nhiệm cho bất cứ sự mất mát, hư hỏng hay trách nhiệm nào khác nếu bạn không tuân thủ điều khoản này do sự truy cập trái phép vào tài khoản của bạn.\n7. Khi có tài khoản sử dụng, bạn được cấp phép để truy cập, sử dụng Ứng dụng Ajent và hoạt động trên các App được lưu trữ bởi Ajent (“App khách hàng”). Mọi nội dung cài đặt hoạt động của bạn, Ajent không có trách nhiệm phê duyệt, kiểm soát nội dung, mà bạn phải tự chịu trách nhiệm sử dụng dịch vụ của mình.\n8. Bạn là người trực tiếp quản lý, duy trì quyền sử dụng các dịch vụ của mình, tự chịu trách nhiệm đối với các hậu quả có thể phát sinh trong trường hợp bạn vi phạm các quy định về sử dụng dịch vụ, hoặc do việc quản lý lỏng lẻo gây ra.\n 9. Bạn hoàn toàn chịu trách nhiệm cho việc tạo bản sao lưu dự phòng và thay thế cho bất kỳ Nội dung bạn đăng hoặc lưu trữ trên App với chi phí của bạn.\n10. Web và Ứng dụng Ajent được cấp phép bởi chủ sở hữu Ajent, Công ty TNHH Glacial Enterprise có trụ sở tại 99 Đường Lê Lợi, Phường Đa Kao, Quận 1, Thành Phố Hồ Chí Minh. Giấy phép này bắt buộc tuân theo các Điều khoản của chính sách này.\n11. Ajent có quyền, tùy quyết định của mình, chấm dứt tài khoản của bạn và truy cập của bạn đến các App, các Ứng dụng Ajent và Dịch vụ hoặc bất kỳ phần nào để loại bỏ hoặc chặn truy cập tới bất kỳ App khách hàng, hoặc nội dung bất kỳ của người dùng ở bất kỳ thời điểm nào. Ajent không chịu bất kỳ trách nhiệm gì với bạn khi thực hiện quyền này của Ajent đồng thời Ajent cũng sẽ không có thông báo cho từng trường hợp.\n12. Các lớp mà bạn tạo ra có thể chứa dịch vụ thông báo, khu vực trao đổi thông tin, nhóm tin, diễn đàn, cộng đồng, các trang web cá nhân và thương mại, lịch, bưu thiếp, và / hoặc phương tiện nhắn tin hoặc các phương tiện thông tin khác được thiết kế để cho phép bạn hoặc người khác có thể giao tiếp với công chúng hoặc nhóm (gọi chung là “Dịch vụ tương tác”), bạn đồng ý sử dụng các Dịch vụ tương tác chỉ để thông báo, gửi và nhận tin nhắn phù hợp với các Chính sách Nội dung, các Điều khoản và pháp luật hiện hành.\n13. Bạn đồng ý chịu trách nhiệm nội dung và rủi ro với các thông tin giao dịch, nội dung trao đổi với người khác của App khách hàng.\n14. Bạn đồng ý rằng không có liên doanh, hợp tác, quan hệ môi giới hoặc bất kỳ hình thức hợp tác nào khác tồn tại giữa bạn và Ajent.\n15. Ajent có quyền đồng ý hỗ trợ hoặc từ chối bạn xuất bản ứng dụng tại Google CH Play (gọi tắt Cửa hàng ứng dụng), bằng việc đồng ý để Ajent hỗ trợ xuất bản ứng dụng là bạn hiểu và chịu trách nhiệm tuân thủ theo toàn bộ chính sách và quy định của Google CH Play, Ajent có toàn quyền xóa hoặc đình chỉ hoạt động App của bạn trên tài khoản xuất bản thuộc sở hữu của Ajent khi có các dấu hiệu vi phạm chính sách Cửa hàng ứng dụng hoặc có khả năng gây ảnh hưởng đến hoạt động của các ứng dụng khác.\n16. Bạn cam kết và hiểu rằng, thông qua việc đồng ý Ajent hỗ trợ xuất bản ứng dụng tại Cửa hàng ứng dụng là bạn đang đồng ý với việc Ajent không phải cam kết và chịu trách nhiệm cho việc tồn tại App của bạn tại Cửa hàng ứng dụng, khi có trường hợp bị Google CH Play hoặc Apple App Store can thiệp như khóa hoặc xóa tài khoản xuất bản thuộc sở hữu của Ajent dẫn đến việc mất App…\n17. Bạn cam kết hiểu rằng, với việc đồng ý để Ajent hỗ trợ xuất bản ứng dụng là bạn đang đồng ý Ajent được toàn quyền sử dụng hình ảnh App của bạn để phục vụ mục đích quảng bá cho Ajent. Đồng thời bạn hiểu rằng, bạn sẽ không thể truy cập vào tài khoản xuất bản của Ajent sở hữu để tùy chỉnh các thông tin liên quan đến App của bạn khi không có sự đồng ý hoặc can thiệp từ phía Ajent.\n18. Với việc sở hữu tài khoản xuất bản riêng tại Cửa hàng ứng dụng, bạn chọn tự xuất bản ứng dụng, bạn sẽ toàn quyền chịu trách nhiệm cho việc xuất bản ứng dụng, cũng như cam kết chính sách của Cửa hàng ứng dụng. Bạn hiểu, việc xuất bản này không đồng nghĩa với việc sở hữu App, dịch vụ Ajent cung cấp là dịch vụ cho thuê hạ tầng theo mô hình SaaS (Software-as-a-Service). Bạn vẫn có trách nhiệm hoàn thành nghĩa vụ thanh toán theo yêu cầu từ phí phát sinh thông qua việc sử dụng thực tế cho Ajent để có thể tiếp tục sử dụng dịch vụ.",
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.normal)),
                  TextSpan(
                      text: "\nĐiều 4. Cam kết khi sử dụng Ajent",
                      style:
                          GoogleFonts.nunitoSans(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          "\nBạn cam kết không thực hiện những điều cấm khi sử dụng Dịch vụ như dưới đây:\n1. Tuyên truyền chiến tranh, khủng bố; gây thù hận, mâu thuẫn giữa các dân tộc, sắc tộc, tôn giáo; chống lại Nhà Nước, gây hại đến an ninh quốc gia và trật tự xã hội.\n2. Tiết lộ bí mật Nhà Nước, bí mật quân sự, an ninh, kinh tế, đối thoại và những bí mật khác do pháp luật quy định.\n3. Tuyên truyền, kích động bạo lực, dâm ô, đồi trụy, tội ác, tệ nạn xã hội, mê tín dị đoan, phá hoại thuần phong, mỹ tục.\n4. Đưa thông tin xuyên tạc, vu khống, xúc phạm uy tín của tổ chức, danh dự và nhân phẩm của cá nhân.\n5. Quảng cáo, tuyên truyền, mua bán hàng hóa, dịch vụ bị cấm; truyền bá tác phẩm báo chí, văn học, nghệ thuật, xuất bản phẩm bị cấm.\n6. Giả mạo tổ chức, cá nhân và phát tán thông tin giả mạo, thông tin sai sự thật xâm hại đến quyền và lợi ích hợp pháp của tổ chức, cá nhân.\n7. Cản trở trái pháp luật việc cung cấp và truy cập thông tin hợp pháp, việc cung cấp và sử dụng và lợi ích hợp pháp trên internet của tổ chức, cá nhân.\n8. Cản trở trái pháp luật hoạt động của hệ thống máy chủ, hoạt động hợp pháp của hệ thống thiết bị cung cấp dịch vụ.\n9. Xâm nhập, sử dụng trái pháp luật mật khẩu, khóa mật mã của tổ chức, cá nhân; thông tin riêng, thông tin cá nhân và tài nguyên internet.\n10. Thu thập, sử dụng, phát tán, kinh doanh trái pháp luật thông tin cá nhân của người khác; lợi dụng sơ hở, điểm yếu của hệ thống thông tin để thu thập, khai thác thông tin cá nhân.\n11. Tạo đường dẫn trái phép đối với tên miền hợp pháp của tổ chức, cá nhân; tấn công, vô hiệu hóa trái pháp luật làm mất tác dụng của biện pháp an toàn thông tin mạng của hệ thống thông tin; tạo, cài đặt, phát tán phần mềm độc hại, vi-rút máy tính; xâm nhập trái phép, chiếm quyền điều khiển hệ thống thông tin, tạo lập công cụ tấn công trên internet.\n12. Có hành động gian lận hoặc bất kỳ hành vi nào quy định tại Điều 4 Thỏa thuận này trên các ứng dụng của Ajent hoặc của một bên thứ ba bất kỳ mà Ajent có hợp tác để hỗ trợ thực hiện dịch vụ của Ajent.\n13. Các điều cấm khác theo quy định pháp luật",
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.normal)),
                  TextSpan(
                      text: "\nĐiều 5. Quyền và nghĩa vụ của Ajent",
                      style:
                          GoogleFonts.nunitoSans(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          "\n1.Ajent có quyền yêu cầu người dùng loại bỏ các thông tin vi phạm quy định tại Điều 4 khi phát hiện các thông tin này.\n2. Có quyền chấm dứt ngay lập tức hoặc đình chỉ tài khoản của bạn, và / hoặc xóa các nội dung của bạn và / hoặc bạn báo cáo cho các cơ quan có thẩm quyền mà Ajent có / hoặc không thông báo cho bạn khi bạn vi phạm bất kỳ phần nào của Thỏa thuận này.\n3. Ajent không có nghĩa vụ chịu trách nhiệm rà soát cho bất kỳ nội dung nào được đăng tải, lưu trữ hoặc tải lên của Bạn hay bên thứ ba khác.\n4. Ajent không chịu trách nhiệm bảo đảm về nội dung trên App với bất kỳ người dùng nào hoặc các thỏa thuận, giao dịch được thực hiện trên App hoặc liên quan giữa các người dùng của Ajent.\n5. Ajent có quyền loại bỏ, theo dõi hoặc chỉnh sửa bất kỳ nội dung nào được đăng tải hoặc được lưu trữ trên ứng dụng của Ajent vào bất kỳ lúc nào và bất kỳ lý do nào mà không cần thông báo cho bạn\n6. Ajent có quyền chấm dứt sự truy cập của bạn đến các trang ứng dụng bất kỳ hoặc tất cả các Dịch vụ của Ajent; loại bỏ hoặc vô hiệu hóa truy cập vào bất kỳ ứng dụng hoặc các nội dung của bạn vào bất kỳ lúc nào mà không cần thông báo vì bất kỳ lý do gì hoặc cho không có lý do.\n7. Ajent cam kết giữ bí mật thông tin mà bạn cung cấp cho chúng tôi hoặc chúng tôi thu thập được và không tiết lộ với bất kỳ bên thứ ba nào trừ khi có yêu cầu từ Cơ quan Nhà nước có thẩm quyền hoặc là cần thiết để (a) thi hành các Điều khoản của Thỏa Thuận này, (b) phát hiện, ngăn chặn gian lận, bảo mật, hoặc các vấn đề kỹ thuật, (c) trả lời các yêu cầu hỗ trợ người dùng hoặc (d) bảo vệ quyền, tài sản hoặc sự an toàn của Ajent, người sử dụng và công chúng.\n8. Ajent không chịu trách nhiệm dưới bất kỳ hình thức nào đối với các thông tin mà bạn cung cấp cho bên thứ ba khi kết nối với Ứng dụng hoặc các bên thứ ba điều hành Ứng dụng, họ có thể sử dụng thông tin cá nhân mà bạn cung cấp cho họ.\n9. Ajent không kiểm soát hay chứng thực nội dung, các thông điệp hoặc thông tin được tìm thấy ở bất kỳ Ứng dụng nào. Ajent không có trách nhiệm pháp lý nào đối với các Ứng dụng và bất kỳ hành động nào gây nên hệ quả từ sự tham gia của bạn trong bất kỳ Ứng dụng nào hoặc việc sử dụng dịch vụ trên các Ứng dụng khác.\n10. Ajent có nghĩa vụ bảo hành kỹ thuật cho bạn trong suốt thời gian sử dụng. Ajent không bảo đảm rằng Ứng dụng của Ajent sẽ đáp ứng yêu cầu của bạn hoặc các hoạt động của chúng sẽ không bị gián đoạn hoặc không bao giờ lỗi.",
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.normal)),
                  TextSpan(
                      text: "\nĐiều 6. Liên kết với bên thứ 3",
                      style:
                          GoogleFonts.nunitoSans(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          "\n1. Ứng dụng của Ajent có thể liên kết và chứa liên kết đến các trang web của bên thứ ba, bao gồm cả liên kết văn bản; đoạn video được nhúng vào; và các ứng dụng phần mềm (Bao gồm cả các tiện ích hỗ trợ về thời tiết; tỷ giá; trò chuyện) (Gọi chung là “Trang Liên Kết”).\n2. Những Trang Liên Kết đều là tài sản của bên thứ ba tương ứng và có thể được bảo vệ bởi / hoặc pháp luật sở hữu trí tuệ và các điều ước quốc tế. Nội dung Trang Liên Kết và thông tin các bên thứ ba này ngoài tầm kiểm soát và / hoặc không thuộc sở hữu và quản lý của Ajent. Ajent không chịu trách nhiệm pháp lý cho bất kỳ nội dung nào của Trang Liên Kết, kể cả rủi ro, thiệt hại kinh tế, thất thoát thông tin dữ liệu có thể phát sinh do việc truy cập Trang Liên Kết.\n3. Ứng dụng Ajent có thể dựa vào bên thứ ba để cung cấp, hoàn thiện một số chức năng. Việc lựa chọn sử dụng những chức năng, ứng dụng phần mềm từ nhà cung cấp thứ ba có thể tạo nên sự thay đổi về mặt cấu trúc hoặc giao diện của App. Người dùng lựa chọn sử dụng và chịu trách nhiệm cho những lựa chọn đó, đồng thời chịu trách nhiệm về thủ tục liên quan đối với các nhà cung cấp thứ ba",
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.normal)),
                  TextSpan(
                      text: "\nĐiều 7. Sử dụng và lưu trữ dữ liệu",
                      style:
                          GoogleFonts.nunitoSans(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          "\n1. Những gì được đăng tải lên App có thể bị giới hạn sao chép, sử dụng và / hoặc phổ biến. Ajent giữ lại quyền để tạo ra và / hoặc thay đổi những giới hạn về sử dụng và lưu trữ bất kỳ lúc nào có hoặc không có thông báo. Bạn có trách nhiệm tôn trọng những giới hạn đó.\n2. Bạn đồng ý rằng Ajent không có trách nhiệm đối với việc mất mát dữ liệu hoặc sự thất bại khi lưu trữ Nội dung hoặc truyền tải bất kỳ nội dung hoặc dịch vụ nào được duy trì bởi Ajent và bạn hoàn toàn chịu trách nhiệm cho việc tạo bản sao lưu dự phòng và thay thế bất kỳ nội dung nào mà bạn đăng tải hoặc lưu trữ trên ứng dụng với chi phí là của bạn.\n3. Ajent bảo hành kỹ thuật cho bạn trong suốt thời gian sử dụng. Bạn đồng ý rằng trước khi gửi yêu cầu hỗ trợ về kỹ thuật App, bạn phải sao lưu tất cả dữ liệu tại thời điểm yêu cầu hỗ trợ kỹ thuật.\n4. Bạn đồng ý rằng dịch vụ lưu trữ dành cho các ứng dụng của Ajent là dịch vụ lưu trữ chia sẻ (shared hosting), có thể dẫn đến việc giới hạn tốc độ truy cập hoặc số lượng truy cập trong cùng một thời điểm và có thể dẫn đến việc hoạt động của ứng dụng bị gián đoạn. Bất kỳ ứng dụng nào vượt quá giới hạn này sẽ được ban hành một cảnh báo vi phạm và đề nghị chuyển đổi App lên hình thức lưu trữ tối ưu hơn.n5. Đối với một số tác vụ đồng bộ dữ liệu từ bên thứ 3 ngoài hệ thống Ajent, bạn hiểu & đồng ý rằng Ajent là hệ thống dịch vụ choa thuê SaaS trên máy chủ chia sẻ, sẽ có giới hạn về tốc độ nhất định về đồng bộ dữ liệu giữa các hệ thống với nhau (dù là Ajent hay các bên thứ 3 đó). Các dữ liệu cần được xử lý tuần tự và có giới hạn nhất định nhằm đảm bảo sự hoạt động ổn định của toàn hệ thống. Ajent có quyền giới hạn xuống mức mà hệ thống chia sẻ của Ajent chấp nhận nếu hệ thống phát hiện có dấu hiệu chiếm dụng tài nguyên hệ thống chung của Ajent (do số lượng yêu cầu lớn từ trong hệ thống đó hoặc do mô hình kinh doanh của bạn). Ajent có thể đề nghị nâng cấp gói cao hơn; hoặc triển khai trên một hệ thống riêng; hoặc từ chối cung cấp dịch vụ kết nối các hệ thống dữ liệu bên thứ 3 này.",
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.normal)),
                  TextSpan(
                      text: "\nĐiều 8. Quyền sở hữu trí tuệ",
                      style:
                          GoogleFonts.nunitoSans(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          "\n1. Tất cả quyền sở hữu trí tuệ tồn tại trong Ứng dụng Ajent đều thuộc về Công ty TNHH Glacial Enterprise hoặc được cấp phép hợp pháp cho Công ty TNHH Glacial Enterprise sử dụng, theo đó, tất cả các quyền hợp pháp đều được đảm bảo. Trừ khi được sự đồng ý của Công ty TNHH Glacial Enterprise, Người Sử Dụng không được phép sử dụng, sao chép, xuất bản, tái sản xuất, truyền hoặc phân phát bằng bất cứ hình thức nào, bất cứ thành phần nào các quyền sở hữu trí tuệ đối với sản phẩm, dịch vụ được nêu trong bản thỏa thuận này.\n2. Chúng tôi có toàn quyền, bao gồm nhưng không giới hạn trong các quyền tác giả, thương hiệu, bí mật kinh doanh, nhãn hiệu và các quyền sở hữu trí tuệ khác trong các dịch vụ trên Ứng dụng Ajent của Công ty TNHH Glacial Enterprise. Việc sử dụng quyền và sở hữu của chúng tôi cần phải được chúng tôi cho phép trước bằng văn bản. Ngoài việc được cấp phép bằng văn bản, chúng tôi không cấp phép dưới bất kỳ hình thức nào khác cho dù đó là hình thức công bố hay hàm ý để bạn thực hiện các quyền trên. Và do vậy, Người Sử Dụng không có quyền sử dụng sản phẩm của chúng tôi vào mục đích thương mại mà không có sự cho phép bằng văn bản của chúng tôi trước đó.\n3. Logo Ajent trong ứng dụng của bạn được hiểu là nhận diện thương hiệu của Ajent, việc tồn tại logo Ajent sẽ đảm bảo rằng ứng dụng của bạn sẽ được bảo hành trong suốt thời gian của dịch vụ. Ngược lại, khi bạn tự ý gỡ bỏ logo Ajent, mà chưa được sự chấp thuận của chúng tôi, có nghĩa là bạn đồng ý rằng chúng tôi không phải có trách nhiệm bảo hành Cửa hàng ứng dụng của bạn",
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.normal)),
                  TextSpan(
                      text: "\nĐiều 9. Miễn trừ trách nhiệm",
                      style:
                          GoogleFonts.nunitoSans(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          "\n1. Trong mọi trường hợp, Ajent không chịu trách nhiệm về các thiết bị, máy móc mà bạn dùng để truy cập vào ứng dụng chúng tôi như: Thiết bị truy cập, thiết bị để chuyển tải. Khi sử dụng dịch vụ, Bạn phải tự trang bị máy móc, thiết bị cần thiết cho quá trình đăng nhập, truyền tải và bạn phải tự chịu mọi trách nhiệm và phí tổn phát sinh trong quá trình sử dụng.\n2. Ajent sẽ không chịu trách nhiệm cho bất kỳ hành động hoặc thiếu sót nào của bên thứ ba, bao gồm nhưng không giới hạn, tổ chức tài chính của bạn, bất kỳ hệ thống thanh toán nào, bất kỳ bên cung cấp dịch vụ thứ ba, bất kỳ nhà cung cấp dịch vụ viễn thông, các điểm truy cập Internet hoặc các trung tâm dữ liệu hoặc thiết bị máy tính hoặc phần mềm, bất kỳ dịch vụ thư tín hoặc dịch vụ giao nhận hoặc cho bất kỳ trường hợp ngoài tầm kiểm soát của Ajent (bao gồm nhưng không giới hạn, cháy, lụt, thảm họa thiên nhiên khác, chiến tranh, bạo loạn, đình công, hành vi dân sự hoặc cơ quan quân sự, thiết bị bị lỗi, virus máy tính, xâm nhập hoặc tấn công bởi một bên thứ ba, hoặc bị gián đoạn điện; viễn thông; dịch vụ tiện ích khác).\n3. Ajent không đảm bảo việc loại trừ các yếu tố gây hại đến việc sử dụng dịch vụ của bạn, bao gồm nhưng không giới hạn những yếu tố sau: Hành vi cố ý vi phạm và gây thiệt hại từ bên thứ ba, hoặc Virus. Chúng tôi không đảm bảo việc cung cấp dịch vụ mà không có bất kỳ sự cố trục trặc, sai chức năng hoặc những vấn đề khác tác động khác nếu có.\n4. Có thể có những yếu tố vượt ra ngoài tầm kiểm soát của chúng tôi dẫn đến việc sản phẩm bị lỗi. Chúng tôi sẽ cố gắng khắc phục lỗi sản phẩm để đem lại sự hài lòng cho khách hàng và chúng tôi không chịu trách nhiệm hỗ trợ hoặc bồi thường cho khách hàng về những rủi ro trên và thiệt hại (nếu có).\n5. Bạn đồng ý bảo vệ, bồi hoàn và loại trừ Chúng tôi khỏi những nghĩa vụ pháp lý, tố tụng, tổn thất, chi phí bao gồm nhưng không giới hạn án phí, chi phí luật sư, chuyên gia tư vấn có liên quan đến việc giải quyết hoặc phát sinh từ sự vi phạm của bạn trong quá trình sử dụng sản phẩm của chúng tôi.\n6. Ajent sẽ không chịu trách nhiệm khi Google CH Play có những thay đổi về chính sách sử dụng ảnh hưởng đến việc sử dụng Dịch vụ của bạn như: App bị xóa hoặc đình chỉ hoạt động",
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.normal)),
                  TextSpan(
                      text: "\nĐiều 10. Điều khoản chung",
                      style:
                          GoogleFonts.nunitoSans(fontWeight: FontWeight.bold)),*/
                  TextSpan(
                      text: "Dr. Fawaz A. Mereani",
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.normal)),
                ]),
          ),
        ),
      ),
    );
  }
}
