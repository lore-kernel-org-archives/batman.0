Return-Path: <martin@hundeboll.net>
Message-ID: <519DAB59.9070001@hundeboll.net>
Date: Thu, 23 May 2013 07:38:33 +0200
From: =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>
MIME-Version: 1.0
References: <1369133299-8325-1-git-send-email-martin@hundeboll.net>
 <1369133299-8325-4-git-send-email-martin@hundeboll.net>
 <20130521191926.GB3435@ritirata.org>
In-Reply-To: <20130521191926.GB3435@ritirata.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 3/3] batman-adv: Fragment and send skbs
 larger than mtu
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

On 2013-05-21 21:19, Antonio Quartulli wrote:
> On Tue, May 21, 2013 at 12:48:19PM +0200, Martin Hundebøll wrote:
>> +static struct sk_buff *batadv_frag_create(struct sk_buff *skb,
>> +					  struct batadv_frag_packet *frag_head,
>> +					  unsigned int mtu)
>> +{
>> +	struct sk_buff *skb_fragment;
>> +	unsigned header_size = sizeof(*frag_head);
>> +	unsigned fragment_size = mtu - header_size;
>> +
>> +	skb_fragment = dev_alloc_skb(mtu + ETH_HLEN);
>> +	if (!skb_fragment)
>> +		goto err;
>> +
>> +	/* Eat the last mtu-bytes of the skb */
>> +	skb_reserve(skb_fragment, header_size + ETH_HLEN);
>> +	skb_split(skb, skb_fragment, skb->len - fragment_size);
>> +
>> +	/* Add the header */
>> +	skb_push(skb_fragment, header_size);
>> +	memcpy(skb_fragment->data, frag_head, header_size);
>
> here we are copying the data right after the Fragment header. However I am not
> sure we are accessing aligned memory because:
>
> ETH_HLEN + header_size = 14 + 20 = 34
>
> To speed up the copy, wouldn't it be better to allocate ETH_HLEN +
> header_size + IP_ALIGN bytes like we do for other packets? (you can use
> netdev_alloc_skb_ip_align() like we do somewhere else).
>
> In this way the memcpy will access a 4bytes aligned memory (if I am not wrong).
>
> Can somebody else comment on this?

I did a quick test by adding some printk-debugging after skb_split() and 
skb_push():
	printk("data: %lu\n", (unsigned long)skb->data % 4);

and it seems like the skb->data pointer is aligned to boundaries of 4 in 
both with and without the use of netdev_alloc_skb_ip_align().

This was done on x86_64 virtual machines. Is there another way this 
should be tested or maybe on some different architecture?

The next revision is pretty much ready, but I will keep it back a bit, 
until someone clarifies this align stuff :)

// Martin



-- 
Kind Regards
Martin Hundebøll
Frederiks Allé 99, 1.th
8000 Aarhus C
Denmark

+45 61 65 54 61
martin@hundeboll.net
