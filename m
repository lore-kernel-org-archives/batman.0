Return-Path: <roland.volkmann@t-online.de>
References: <56F5AF2F.6060904@t-online.de> <4605306.DPF6tJRphQ@sven-edge>
 <56FB11B7.10103@t-online.de> <4506388.qOszBEsOk4@bentobox>
From: Roland Volkmann <roland.volkmann@t-online.de>
Message-ID: <56FB97E7.5050708@t-online.de>
Date: Wed, 30 Mar 2016 11:09:59 +0200
MIME-Version: 1.0
In-Reply-To: <4506388.qOszBEsOk4@bentobox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] No rebroadcast on mesh links
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

>>> And btw. it is not about the originator. It is handled in 
>>> batadv_send_outstanding_bcast_packet at the same place where you 
>>> want to have the no_rebroadcast check. no_rebroadcast in the patch 
>>> we are talking [1,2] about is currently just ignoring the num_bcasts 
>>> of a hard-interface for some situations (when forw_packet->skb->dev 
>>> == hard_iface->net_dev). 
>> Let's have a look to the source code. The interesting part is 
>> function "static void batadv_send_outstanding_bcast_packet(struct 
>> work_struct *work)" in file "send.c". There you will find 
> To what are you answering? At least not to my statement.
>> [...] 
> No, it isn't about the incoming or outgoing hard-interfaces. See 
> Marek's reply.

Sorry, that was a misunderstanding. Before Marek's explanation (thank 
you for that) I was read it as comparing incoming to outgoing interface.

>> Here is an updated version of the patch as it is used in current 
>> master branch of gluon matching batman-adv 2016.0: 
> Not sure why you sent some(tm) patch of a patch in this way when there 
> is a guideline how to correctly send them [1]

This was not an official launch of a patch but for information only. 
Neither I myself have a required development environment nor do I like 
to launch Linus' patch as mine. And because of too few knowledge about 
Linux and batman-adv internals, my only contribution can be to show the 
relevance of this issue for Freifunk installations, and looking for 
somebody who can implement the necessary stuff.

Best regards,
Roland.

