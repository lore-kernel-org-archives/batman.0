Return-Path: <post@tiwoc.de>
Message-ID: <4B7918EC.40100@tiwoc.de>
Date: Mon, 15 Feb 2010 10:50:36 +0100
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

Marek Lindner schrieb:
> I don't think it will be necessary to change the packet size dynamically. The 
> gain will be rather small compared to the overhead it creates. However, it 
> would make sense to specify 2 different icmp structs and only send the large 
> packet when RR is really needed. 

Sounds good, I'll prepare a new version of the patch.

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

You're right, I'll change this.

Regards, Daniel
