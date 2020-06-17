Return-Path: <ll@simonwunderlich.de>
Subject: Re: [PATCH] mac80211: mesh: add mesh_param "mesh_nolearn" to skip
 path discovery
From: =?UTF-8?Q?Linus_L=c3=bcssing?= <ll@simonwunderlich.de>
References: <20200616095358.20143-1-linus.luessing@c0d3.blue>
 <cbe4863e-44f3-c0e4-a4f3-1b0a69f7a386@simonwunderlich.de>
Message-ID: <6bef8071-f897-b972-dbf9-17198361dc4e@simonwunderlich.de>
Date: Wed, 17 Jun 2020 09:45:34 +0200
MIME-Version: 1.0
In-Reply-To: <cbe4863e-44f3-c0e4-a4f3-1b0a69f7a386@simonwunderlich.de>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: =?UTF-8?Q?Linus_L=c3=bcssing?= <linus.luessing@c0d3.blue>, Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

On 16/06/2020 12:16, Linus Lüssing wrote:
>> The new mesh_nolearn parameter allows to skip the PREQ/PREP exchange in
>> this scenario, leading to a reduced delay, reduced packet buffering and
>> simplifies HWMP in general.

And a third observation we've made with HWMP:

When running iperf with 16 parallel TCP streams and the default HWMP 
parameters over two 4x4 802.11ac Wave 2 wifi cards transmitting about 
800-1000 MBit/s in total, HWMP becomes quite unstable. We see frequent 
PREQ/PREP retransmissions and also PERR messages, leading to spurious 
break downs in the throughput.

When using just 8 TCP streams, so with a little less saturation and 
stress of the channel, iperf staticstics are stable.


So maybe there would be some potential for optimizations, too, like 
somehow prioritizing HWMP messages more, or maybe making the default 
HWMP parameters a bit more conservative.


Or just disabling the HWMP PREP/PREQ/PERR exchange with this new 
configuration option would at least help the ones that are using another 
mesh routing protocol on top, who are maybe more familiar with the 
parameters of their specific routing protocol than with the HWMP parameters.

Regards, Linus
