Return-Path: <martin@hundeboll.net>
Message-ID: <519DA425.30708@hundeboll.net>
Date: Thu, 23 May 2013 07:07:49 +0200
From: =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>
MIME-Version: 1.0
References: <1369133299-8325-1-git-send-email-martin@hundeboll.net>
 <1369133299-8325-3-git-send-email-martin@hundeboll.net>
 <20130521191011.GA3435@ritirata.org>
In-Reply-To: <20130521191011.GA3435@ritirata.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 2/3] batman-adv: Receive fragmented
 packets and merge
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Antonio Quartulli <ordex@autistici.org>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi Antonio,

Thanks for your carefull reviews!

On 2013-05-21 21:10, Antonio Quartulli wrote:
> On Tue, May 21, 2013 at 12:48:18PM +0200, Martin Hundebøll wrote:
>> +	/* Forward the fragment, if the merged packet would be too big to
>> +	 * be assembled.
>> +	 */
>> +	total_size = ntohs(packet->total_size) + ETH_HLEN;
>> +	if (total_size > neigh_node->if_incoming->net_dev->mtu) {
>
> I guess here you forgot to remove the ETH_LEN from the total_size computation.

True.

>> +		batadv_inc_counter(bat_priv, BATADV_CNT_FRAG_FWD);
>> +		batadv_add_counter(bat_priv, BATADV_CNT_FRAG_FWD_BYTES,
>> +				   skb->len + ETH_HLEN);
>
> and here should ETH_HLEN be counted in the amount of bytes sent?

I would say so, yes, since batadv_send_skb_packet() will add an ethernet 
header to the packet before transmitting it.

> Moreover we are always avoiding third person in kernel doc ("Returns" should be
> "Return" and so on..) and you should not put () (in the kernel doc).

Will do so and send another revision...

-- 
Kind Regards
Martin Hundebøll
Frederiks Allé 99, 1.th
8000 Aarhus C
Denmark

+45 61 65 54 61
martin@hundeboll.net
