import 'package:dio/dio.dart';

import 'package:retrofit/http.dart';
import 'package:sigma_marketing/data/datasources/remote/token_interceptor.dart';
import 'package:sigma_marketing/data/models/paged_list/paged_list.dart';
import 'package:sigma_marketing/data/models/request/payment/paypal_email.dart';
import 'package:sigma_marketing/data/models/request/payment/purchase.dart';
import 'package:sigma_marketing/data/models/response/brand/campaign_analytics/campaign_analytics.dart';
import 'package:sigma_marketing/data/models/response/payments/payment_brand.dart';

import '../../../config/constants.dart';
import '../../models/request/achievement/achievement_submit.dart';
import '../../models/request/brand/campaign_analytics/campaign_analytics_request.dart';
import '../../models/request/brand/new_campaign/new_campaign.dart';
import '../../models/request/campaign/campaign_state.dart';
import '../../models/request/chat/new_message.dart';
import '../../models/request/invite/invite.dart';
import '../../models/request/payment/transfer.dart';
import '../../models/request/payment/withdraw.dart';
import '../../models/request/registration/new_profile.dart';
import '../../models/response/brand/campaign/campaign_brand.dart';
import '../../models/response/brand/campaign_details/campaign_details_brand.dart';
import '../../models/response/campaign/achievement_point.dart';
import '../../models/response/campaign/campaign.dart';
import '../../models/response/campaign/campaign_details.dart';
import '../../models/response/campaign/my_campaigns.dart';
import '../../models/response/chat/conversation.dart';
import '../../models/response/chat/message.dart';
import '../../models/response/new_campaign/campaign_create_data.dart';
import '../../models/response/notification/notification_sigma.dart';
import '../../models/response/payment_user/payment_user.dart';
import '../../models/response/profile/profile_details.dart';
import '../../models/response/sigma_token/sigma_token.dart';
import '../../models/response/token/token.dart';
import '../../models/response/user/search_user.dart';

/// this service class is similar as Retrofit service (Android)
/// where we need to declare api type, parameters and return type etc.
/// build_runner tool will generate the code for this service
part 'api_service.g.dart';

@RestApi(baseUrl: AppConstants.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {required String baseUrl}) {
    dio.options = BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      contentType: 'application/json',
      headers: {
        'Accept': 'application/json',
      },
    );

    dio.interceptors.add(TokenInterceptor());

    return _ApiService(dio, baseUrl: baseUrl);
  }

  // #########################################################################
  // ######### COMMON APIs ##########################################
  // #########################################################################

  // Achievement APIs ----------------------------------------------------
  @GET("Achievement/GetById")
  Future<AchievementPoint> getAchievementById(@Query("id") int id);

  @POST("Achievement/SubmitReview")
  Future<AchievementPoint> submitReview(
    @Body() AchievementSubmit achievementSubmit,
  );

  @POST("Achievement/SubmitRevision")
  Future<AchievementPoint> submitRevision(
    @Body() AchievementSubmit achievementSubmit,
  );

  @POST("Achievement/Complete")
  Future<AchievementPoint> completeAchievement(
    @Query("achievementId") int achievementId,
  );

  // #########################################################################
  // ######### INFLUENCER APIs ##########################################
  // #########################################################################

  // Account APIs ----------------------------------------------------
  @POST("Account/SignIn")
  Future<Token> signIn(
      @Query("email") String email, @Query("password") String password);

  @POST("Account/CreateInfluencerProfile")
  Future<Token> createInfluencerProfile(@Body() NewProfile newMessage);

  @GET("Account/GetProfile")
  Future<ProfileDetails> getProfileDetails();

  // Campaign APIs ----------------------------------------------------
  @GET("CampaignInfluencer/GetAll")
  Future<PagedList<Campaign>> getAll(@Query("query") String? query,
      @Query("page") int page, @Query("pageSize") int pageSize);

  @POST("CampaignInfluencer/ToggleLikeCampaign")
  Future<Campaign> toggleLikeCampaign(
      @Query("campaignId") int campaignId, @Query("liked") bool liked);

  @GET("CampaignInfluencer/GetById")
  Future<CampaignDetails> getCampaignDetails(@Query("id") int campaignId);

  @GET("CampaignInfluencer/GetMyCampaigns")
  Future<MyCampaigns> getMyCampaigns();

  @POST("CampaignInfluencer/Update")
  Future<CampaignDetails> updateCampaign(@Body() CampaignState campaignState);

  // Notification APIs ----------------------------------------------------
  @GET("Notification/GetNotifications")
  Future<PagedList<NotificationSigma>> getNotifications(
      @Query("page") int page, @Query("pageSize") int pageSize);

  @PUT("Notification/SetNotificationOpen")
  Future<NotificationSigma> setNotificationOpen(
      @Query("id") int notificationId);

  @POST("Notification/SaveNotificationToken")
  Future<bool> saveNotificationToken(@Query("token") String token);

  // Chat APIs ----------------------------------------------------
  @GET("Chat/GetConversations")
  Future<PagedList<Conversation>> getConversations(
      @Query("page") int page, @Query("pageSize") int pageSize);

  @GET("Chat/GetConversationChat")
  Future<PagedList<Message>> getConversationChat(
    @Query("receiverId") int receiverId,
    @Query("page") int page,
    @Query("pageSize") int pageSize,
  );

  @POST("Chat/SendMessage")
  Future<Message> sendMessage(@Body() NewMessage newMessage);

  @POST("Chat/ReadMessages")
  Future<bool> readMessages(@Query("receiverId") int receiverId);

  @GET("Account/SearchUsers")
  Future<List<SearchUser>> searchUsers(@Query("query") String? query);

  // Sigma Token APIs ----------------------------------------------------
  @GET("SigmaToken/GetSigmaTokensPackages")
  Future<List<SigmaToken>> getSigmaTokensPackages();

  @POST("SigmaToken/PurchaseTokens")
  Future<bool> purchaseTokens(@Body() Purchase purchase);

  @GET("SigmaToken/GetPaymentsBrand")
  Future<PaymentBrand> getPaymentsBrand();

  @GET("SigmaToken/GetPaymentsUser")
  Future<PaymentUser> getPaymentsUser();

  @POST("SigmaToken/Withdraw")
  Future<bool> withdraw(@Body() Withdraw withdraw);

  @POST("SigmaToken/Payout")
  Future<CampaignDetailsBrand> payout(@Body() Transfer transfer);

  @POST("SigmaToken/UpdatePaypalEmail")
  Future<PaymentUser> updatePaypalEmail(@Body() PaypalEmail paypalEmail);

  // #########################################################################
  // ######### CAMPAIGNS BRAND API ##########################################
  // #########################################################################

  @GET("CampaignBrand/GetBrandCampaigns")
  Future<PagedList<CampaignBrand>> getBrandCampaigns(
      @Query("query") String? query,
      @Query("page") int page,
      @Query("pageSize") int pageSize);

  @GET("CampaignBrand/GetCampaignByIdCompany")
  Future<CampaignDetailsBrand> getCampaignByIdCompany(@Query("id") int id);

  @POST("Analytics/GetCampaignsAnalytics")
  Future<CampaignAnalytics> getCampaignsAnalytics(
      @Body() CampaignAnalyticsRequest campaignAnalyticsRequest);

  @POST("CampaignBrand/CreateCampaign")
  Future<String> createCampaign(@Body() NewCampaignRequest newCampaignRequest);

  @GET("CampaignBrand/GetCampaignCreateData")
  Future<CampaignCreateData> getCampaignCreateData();

  @POST("CampaignBrand/InviteUsers")
  Future<bool> inviteUsers(@Body() Invite invite);

  @POST("CampaignBrand/AcceptUser")
  Future<CampaignDetailsBrand> acceptUser(
    @Query("campaignId") int campaignId,
    @Query("influencerId") int influencerId,
  );

  @POST("CampaignBrand/DeclineUser")
  Future<CampaignDetailsBrand> declineUser(
    @Query("campaignId") int campaignId,
    @Query("influencerId") int influencerId,
  );
}
