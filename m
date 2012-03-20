Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 20 Mar 2012 14:01:59 +0100
References: <1331909900-25173-1-git-send-email-ordex@autistici.org>
	<1331917408-2304-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1331917408-2304-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201203201402.00110.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: improve unicast packet
	(re)routing
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Friday, March 16, 2012 18:03:28 Antonio Quartulli wrote:
> In case of a client X roaming from a generic node A to another node B, it
> is possible that a third node C gets A's OGM but not B's. At this point in
> time, if C wants to send data to X it will send a unicast packet destined
> to A. The packet header will contain A's last ttvn (C got A's OGM and so
> it knows it).
> 
> The packet will travel towards A without being intercepted because the ttvn
> contained in its header is the newest for A.
> 
> Once A will receive the packet, A's state will not report to be in a
> "roaming phase" (because, after a roaming, once A sends out its OGM, all
> the changes are committed and the node is considered not to be in the
> roaming state anymore) and it will match the ttvn carried by the packet.
> Therefore there is no reason for A to try to alter the packet's route,
> thus dropping the packet because the destination client is not there
> anymore.
> 
> However, C is well aware that it's routing information towards the client X
> is outdated as it received an OGM from A saying that the client roamed
> away. Thanks to this detail, this patch introduces a small change in
> behaviour: as long as C is in the state of not knowing the new location of
> client X it will forward the traffic to its last known location using
> ttvn-1 of the destination. By using an older ttvn node A will be forced to
> re-route the packet. Intermediate nodes are also allowed to update the
> packet's destination as long as they have the information about the
> client's new location.

Applied in revision b46c60b.

Thanks,
Marek
