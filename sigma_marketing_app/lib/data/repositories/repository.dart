import 'package:sigma_marketing/data/models/response/sigma_token/sigma_token.dart';

import '../models/paged_list/paged_list.dart';
import '../models/request/achievement/achievement_submit.dart';
import '../models/request/brand/campaign_analytics/campaign_analytics_request.dart';
import '../models/request/brand/new_campaign/new_campaign.dart';
import '../models/request/campaign/campaign_state.dart';
import '../models/request/chat/new_message.dart';
import '../models/request/invite/invite.dart';
import '../models/request/payment/paypal_email.dart';
import '../models/request/payment/purchase.dart';
import '../models/request/payment/transfer.dart';
import '../models/request/payment/withdraw.dart';
import '../models/response/brand/campaign/campaign_brand.dart';
import '../models/response/brand/campaign_analytics/campaign_analytics.dart';
import '../models/response/brand/campaign_details/campaign_details_brand.dart';
import '../models/response/campaign/achievement_point.dart';
import '../models/response/campaign/campaign.dart';
import '../models/response/campaign/campaign_details.dart';
import '../models/response/campaign/my_campaigns.dart';
import '../models/response/chat/conversation.dart';
import '../models/response/chat/message.dart';
import '../models/response/new_campaign/campaign_create_data.dart';
import '../models/response/notification/notification_sigma.dart';
import '../models/response/payment_user/payment_user.dart';
import '../models/response/payments/payment_brand.dart';
import '../models/response/profile/profile_details.dart';
import '../models/response/user/search_user.dart';
import 'base/base_repository.dart';

abstract class Repository extends BaseRepository {
  // #########################################################################
  // ######### COMMON APIs ##########################################
  // #########################################################################

  // Achievement APIs ----------------------------------------------------
  Future<AchievementPoint> getAchievementById(int id);

  Future<AchievementPoint> submitReview(AchievementSubmit achievementSubmit);

  Future<AchievementPoint> submitRevision(AchievementSubmit achievementSubmit);

  Future<AchievementPoint> completeAchievement(int achievementId);

  // Account APIs ----------------------------------------------------
  Future<ProfileDetails> getProfileDetails();

  // Campaign APIs ----------------------------------------------------
  Future<PagedList<Campaign>> getAll(String? query, int page, int pageSize);

  Future<Campaign> toggleLikeCampaign(int campaignId, bool liked);

  Future<CampaignDetails> getCampaignDetails(int campaignId);

  Future<MyCampaigns> getMyCampaigns();

  Future<CampaignDetails> updateCampaign(CampaignState campaignState);

  // Notification APIs ----------------------------------------------------
  Future<PagedList<NotificationSigma>> getNotifications(int page, int pageSize);

  Future<NotificationSigma> setNotificationOpen(int notificationId);

  Future<bool> saveNotificationToken(String token);

  // Chat APIs ----------------------------------------------------
  Future<PagedList<Conversation>> getConversations(int page, int pageSize);

  Future<PagedList<Message>> getConversationChat(
      int receiverId, int page, int pageSize);

  Future<Message> sendMessage(NewMessage newMessage);

  Future<bool> readMessages(int receiverId);

  Future<List<SearchUser>> searchUsers(String? query);

  // Sigma Tokens APIs ----------------------------------------------------
  Future<List<SigmaToken>> getSigmaTokensPackages();

  Future<bool> purchaseTokens(Purchase purchase);

  Future<PaymentBrand> getPaymentsBrand();

  Future<PaymentUser> getPaymentsUser();

  Future<bool> withdraw(Withdraw withdraw);

  Future<CampaignDetailsBrand> payout(Transfer transfer);

  Future<PaymentUser> updatePaypalEmail(PaypalEmail paypalEmail);

  // #########################################################################
  // ######### CAMPAIGNS BRAND API ##########################################
  // #########################################################################

  Future<PagedList<CampaignBrand>> getBrandCampaigns(
      String? query, int page, int pageSize);

  Future<CampaignDetailsBrand> getCampaignByIdCompany(int id);

  Future<CampaignAnalytics> getCampaignsAnalytics(
      CampaignAnalyticsRequest campaignAnalyticsRequest);

  Future<String> createCampaign(NewCampaignRequest newCampaignRequest);

  Future<CampaignCreateData> getCampaignCreateData();

  Future<bool> inviteUsers(Invite invite);

  Future<CampaignDetailsBrand> acceptUser(int campaignId, int influencerId);

  Future<CampaignDetailsBrand> declineUser(int campaignId, int influencerId);
}
