Return-Path: <dingtianhong@huawei.com>
Message-ID: <52B7FDB2.6090700@huawei.com>
Date: Mon, 23 Dec 2013 17:09:06 +0800
From: Ding Tianhong <dingtianhong@huawei.com>
MIME-Version: 1.0
References: <52B7C5C5.2050304@huawei.com> <52B7F853.8050806@meshcoding.com>
In-Reply-To: <52B7F853.8050806@meshcoding.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 09/21] batman-adv: slight optimization of
	addr compare
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
To: Antonio Quartulli <antonio@meshcoding.com>, Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, "David S. Miller" <davem@davemloft.net>, b.a.t.m.a.n@lists.open-mesh.org, Netdev <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 2013/12/23 16:46, Antonio Quartulli wrote:
> On 23/12/13 06:10, Ding Tianhong wrote:
> 
> [...]
> 
>> --- a/net/batman-adv/originator.c
>> +++ b/net/batman-adv/originator.c
>> @@ -41,7 +41,7 @@ int batadv_compare_orig(const struct hlist_node *node, const void *data2)
>>  	const void *data1 = container_of(node, struct batadv_orig_node,
>>  					 hash_entry);
>>  
>> -	return (memcmp(data1, data2, ETH_ALEN) == 0 ? 1 : 0);
>> +	return ether_addr_equal_unaligned(data1, data2) ? 1 : 0;
> 
> ether_addr_equal_unaligned() returns a bool value which is implicitly
> converted to 1 or 0: there is no need for the ternary if anymore.
> 
> 
>>  }
>>  
>>  /**
>> diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
>> index 4add57d..5e66d4b 100644
>> --- a/net/batman-adv/translation-table.c
>> +++ b/net/batman-adv/translation-table.c
>> @@ -51,7 +51,7 @@ static int batadv_compare_tt(const struct hlist_node *node, const void *data2)
>>  	const void *data1 = container_of(node, struct batadv_tt_common_entry,
>>  					 hash_entry);
>>  
>> -	return (memcmp(data1, data2, ETH_ALEN) == 0 ? 1 : 0);
>> +	return ether_addr_equal_unaligned(data1, data2) ? 1 : 0;
> 
> same here
> 
> 
> Moreover, include linux/etherdevice.h in both files as explained in
> point 1) of Documentation/SubmitChecklist
> 
> Thanks.
> 
> 
> 
> Cheers,
> 

Yes, thanks a lot, fix it soon.

Regards
Ding



