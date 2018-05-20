Return-Path: <jiri@resnulli.us>
Date: Sun, 20 May 2018 08:19:54 +0200
From: Jiri Pirko <jiri@resnulli.us>
Message-ID: <20180520061954.GA2255@nanopsycho.orion>
References: <20161027190150.7880-1-sw@simonwunderlich.de>
 <20161027190150.7880-4-sw@simonwunderlich.de>
 <20161029103301.GD1692@nanopsycho.orion>
 <22392280.4UY6GoIrAk@sven-edge>
 <20161029105628.GE1692@nanopsycho.orion>
 <20180327154307.GA2052@otheros>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180327154307.GA2052@otheros>
Subject: Re: [B.A.T.M.A.N.] [PATCH 03/17] batman-adv: Add network_coding and
 mcast sysfs files to README
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Sven Eckelmann <sven@narfation.org>, netdev@vger.kernel.org, davem@davemloft.net

Tue, Mar 27, 2018 at 05:43:08PM CEST, linus.luessing@c0d3.blue wrote:
>On Sat, Oct 29, 2016 at 12:56:28PM +0200, Jiri Pirko wrote:
>> >> I strongly believe it is a huge mistake to use sysfs for things like
>> >> this. This should be done via generic netlink api.
>> >
>> >This doesn't change the problem that it is already that way. This patch
>> >only adds the list of available files to the README.
>> 
>> Sure. Just found out you did it like that. Therefore I commented. I
>> suggest to rework the api to use genl entirely.
>
>Hi Jiri,
>
>Thanks for sharing your thoughts!
>
>Could you explain a bit more on which disadvantages you see in
>the usage of sysfs here?

There are 2 major disadvantages.
1) You don't have any events on a change. An app has to poll in order to
   know what changed in kernel. Netlink handles this by sending
   multicast messages on a specific socket while whoever is interested
   gets the messages.
2) In sysfs, everything is string. There are even mixed values like
   "1 (means something)". There are no well defined values. Every driver
   can expose same things differently. In Netlink, you have well-defined
   attributes, with typed values. You can pass multiple attributes for
   the same value if needed.

In general, usage of sysfs in netdev subsystem is frowned upon. I would
suggest to convert your iface to Generic Netlink API and let the
existing sysfs API to rot.


>
>Regards, Linus
