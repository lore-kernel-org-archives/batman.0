Return-Path: <post@tiwoc.de>
Message-ID: <4B796A1B.1090307@tiwoc.de>
Date: Mon, 15 Feb 2010 16:36:59 +0100
From: Daniel Seither <post@tiwoc.de>
MIME-Version: 1.0
References: <4B759F67.5090407@tiwoc.de>
	<201002142236.43721.lindner_marek@yahoo.de>
In-Reply-To: <201002142236.43721.lindner_marek@yahoo.de>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Record route for
	ICMP	messages
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

I just sent an improved patch.

Marek Lindner schrieb:
>> +	/* add record route information if not full */
>> +	if (icmp_packet->rr_cur && icmp_packet->rr_cur < BAT_RR_LEN / ETH_ALEN) {
>> +		memcpy(&(icmp_packet->rr[icmp_packet->rr_cur * ETH_ALEN]),
>> ethhdr->h_dest, ETH_ALEN);
>> +		icmp_packet->rr_cur++;
>> +	}
> 
> It would be better to check for the actual packet size rather than the 
> BAT_RR_LEN define. Some node might have sent us an icmp packet which had a 
> different size and then we crash here (or worse).

This should not be the case because, preliminary to adding RR info, it
is checked whether the received frame is long enough for the given
packet_type (at least in the current version of the patch).

Regards, Daniel
