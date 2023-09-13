import 'package:injectable/injectable.dart';
import 'package:sigma_marketing/data/models/request/payment/purchase.dart';

import '../datasources/remote/api_service.dart';
import '../models/paged_list/paged_list.dart';
import '../models/request/achievement/achievement_submit.dart';
import '../models/request/brand/campaign_analytics/campaign_analytics_request.dart';
import '../models/request/brand/new_campaign/new_campaign.dart';
import '../models/request/campaign/campaign_state.dart';
import '../models/request/chat/new_message.dart';
import '../models/request/invite/invite.dart';
import '../models/request/payment/paypal_email.dart';
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
import '../models/response/sigma_token/sigma_token.dart';
import '../models/response/user/search_user.dart';
import 'repository.dart';

@Singleton(as: Repository)
class RepositoryImpl extends Repository {
  ApiService get _apiService => ApiService(dio, baseUrl: endpoint);

  // #########################################################################
  // ######### COMMON APIs ##########################################
  // #########################################################################

  // Achievement APIs ----------------------------------------------------
  @override
  Future<AchievementPoint> getAchievementById(int id) {
    return _apiService.getAchievementById(id);
  }

  @override
  Future<AchievementPoint> submitReview(AchievementSubmit achievementSubmit) {
    return _apiService.submitReview(achievementSubmit);
  }

  @override
  Future<AchievementPoint> submitRevision(AchievementSubmit achievementSubmit) {
    return _apiService.submitRevision(achievementSubmit);
  }

  @override
  Future<AchievementPoint> completeAchievement(int achievementId) {
    return _apiService.completeAchievement(achievementId);
  }

  // Account APIs ----------------------------------------------------
  @override
  Future<ProfileDetails> getProfileDetails() {
    return _apiService.getProfileDetails();
  }

  // Campaign APIs ----------------------------------------------------
  @override
  Future<PagedList<Campaign>> getAll(String? query, int page, int pageSize) {
    return _apiService.getAll(query, page, pageSize);
  }

  @override
  Future<Campaign> toggleLikeCampaign(int campaignId, bool liked) {
    return _apiService.toggleLikeCampaign(campaignId, liked);
  }

  @override
  Future<CampaignDetails> getCampaignDetails(int campaignId) {
    return _apiService.getCampaignDetails(campaignId);
  }

  @override
  Future<MyCampaigns> getMyCampaigns() {
    return _apiService.getMyCampaigns();
  }

  @override
  Future<CampaignDetails> updateCampaign(CampaignState campaignState) {
    return _apiService.updateCampaign(campaignState);
  }

  // Notification APIs ----------------------------------------------------
  @override
  Future<PagedList<NotificationSigma>> getNotifications(
      int page, int pageSize) {
    return _apiService.getNotifications(page, pageSize);
  }

  @override
  Future<NotificationSigma> setNotificationOpen(int notificationId) {
    return _apiService.setNotificationOpen(notificationId);
  }

  @override
  Future<bool> saveNotificationToken(String token) {
    return _apiService.saveNotificationToken(token);
  }

  // Chat APIs ----------------------------------------------------
  @override
  Future<PagedList<Conversation>> getConversations(int page, int pageSize) {
    return _apiService.getConversations(page, pageSize);
  }

  @override
  Future<PagedList<Message>> getConversationChat(
      int receiverId, int page, int pageSize) {
    return _apiService.getConversationChat(receiverId, page, pageSize);
  }

  @override
  Future<Message> sendMessage(NewMessage newMessage) {
    return _apiService.sendMessage(newMessage);
  }

  @override
  Future<bool> readMessages(int receiverId) {
    return _apiService.readMessages(receiverId);
  }

  @override
  Future<List<SearchUser>> searchUsers(String? query) {
    return _apiService.searchUsers(query);
  }

  // Sigma Tokens APIs ----------------------------------------------------
  @override
  Future<List<SigmaToken>> getSigmaTokensPackages() {
    return _apiService.getSigmaTokensPackages();
  }

  @override
  Future<bool> purchaseTokens(Purchase purchase) {
    return _apiService.purchaseTokens(purchase);
  }

  @override
  Future<PaymentBrand> getPaymentsBrand() {
    return _apiService.getPaymentsBrand();
  }

  @override
  Future<PaymentUser> getPaymentsUser() {
    return _apiService.getPaymentsUser();
  }

  @override
  Future<bool> withdraw(Withdraw withdraw) {
    return _apiService.withdraw(withdraw);
  }

  @override
  Future<CampaignDetailsBrand> payout(Transfer transfer) {
    return _apiService.payout(transfer);
  }

  @override
  Future<PaymentUser> updatePaypalEmail(PaypalEmail paypalEmail){
    return _apiService.updatePaypalEmail(paypalEmail);
  }

  // #########################################################################
  // ######### CAMPAIGNS BRAND API ##########################################
  // #########################################################################

  @override
  Future<PagedList<CampaignBrand>> getBrandCampaigns(
      String? query, int page, int pageSize) {
    return _apiService.getBrandCampaigns(query, page, pageSize);
  }

  @override
  Future<CampaignDetailsBrand> getCampaignByIdCompany(int id) {
    return _apiService.getCampaignByIdCompany(id);
  }

  @override
  Future<CampaignAnalytics> getCampaignsAnalytics(
      CampaignAnalyticsRequest campaignAnalyticsRequest) {
    return _apiService.getCampaignsAnalytics(campaignAnalyticsRequest);
  }

  @override
  Future<String> createCampaign(NewCampaignRequest newCampaignRequest) {
    return _apiService.createCampaign(newCampaignRequest);
  }

  @override
  Future<CampaignCreateData> getCampaignCreateData() {
    return _apiService.getCampaignCreateData();
  }

  @override
  Future<bool> inviteUsers(Invite invite) {
    return _apiService.inviteUsers(invite);
  }

  @override
  Future<CampaignDetailsBrand> acceptUser(int campaignId, int influencerId) {
    return _apiService.acceptUser(campaignId, influencerId);
  }

  @override
  Future<CampaignDetailsBrand> declineUser(int campaignId, int influencerId) {
    return _apiService.declineUser(campaignId, influencerId);
  }
}
