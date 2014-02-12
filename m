Return-Path: <nbd@openwrt.org>
Message-ID: <52FB6F04.3000404@openwrt.org>
Date: Wed, 12 Feb 2014 13:54:28 +0100
From: Felix Fietkau <nbd@openwrt.org>
MIME-Version: 1.0
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
 <1392122903-805-16-git-send-email-antonio@meshcoding.com>
 <20140212091215.GI30814@lunn.ch> <52FB6525.7090001@open-mesh.com>
In-Reply-To: <52FB6525.7090001@open-mesh.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [RFC 15/23] batman-adv: ELP - send unicast ELP
 packets for throughput sampling
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
To: Antonio Quartulli <antonio@open-mesh.com>, Andrew Lunn <andrew@lunn.ch>, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On 2014-02-12 13:12, Antonio Quartulli wrote:
> On 12/02/14 10:12, Andrew Lunn wrote:
>> On Tue, Feb 11, 2014 at 01:48:15PM +0100, Antonio Quartulli wrote:
>>> From: Antonio Quartulli <antonio@open-mesh.com>
>>>
>>> In case of a unused link, the throughput estimation will
>>> get stuck to the last sampled value and therefore the
>>> reported metric will becomes obsolete.
>>>
>>> Send unicast ELP packets to each neighbor to trigger throughput
>>> sampling on unused links.
>> 
>> Humm, i can understand the need for this, but i really think the rate
>> control code should be sending the probes, not batman. What do the
>> wifi people say about this? Have they tried submitting patches to
>> them?
> 
> I am CC'ing Felix so that he can give his opinion.
> But last time I checked Minstrel I realised that it uses data packets to
> probe rates (there is not a specific probing packet), meaning that if
> there is no data packet to send, then no probing is performed.
Correct. Minstrel never sends dedicated probing packets. Changing
minstrel to send active probing packets to serve the needs of batman
would be a very bad idea, because pretty much all regular users do not
have any need for extra probing.

> Sending this ELP packets (when there is no unicast traffic) is a way to
> trigger this mechanism in Minstrel.
Right. If I remember correctly, if you send less than 1 packet per 100
ms, then all packets should end up being probing packets. If that
doesn't work, we can change minstrel's probing pattern to allow things
like batman to get a desirable amount of rate control probing simply by
sending unicast packets.

- Felix
