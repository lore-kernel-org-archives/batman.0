Return-Path: <jiri@resnulli.us>
Date: Sat, 4 Aug 2018 13:52:12 +0200
From: Jiri Pirko <jiri@resnulli.us>
Message-ID: <20180804115212.GD2015@nanopsycho>
References: <20161027190150.7880-1-sw@simonwunderlich.de>
 <20161027190150.7880-4-sw@simonwunderlich.de>
 <20161029103301.GD1692@nanopsycho.orion>
 <22392280.4UY6GoIrAk@sven-edge>
 <20161029105628.GE1692@nanopsycho.orion>
 <20180327154307.GA2052@otheros>
 <20180520061954.GA2255@nanopsycho.orion>
 <113e9222-3310-71c6-7cec-c253b9b5d194@unstable.cc>
 <20180804093632.GB2015@nanopsycho>
 <f2964fca-072e-2a6c-4ce9-aa7963465195@unstable.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2964fca-072e-2a6c-4ce9-aa7963465195@unstable.cc>
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
To: Antonio Quartulli <a@unstable.cc>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>, netdev@vger.kernel.org, davem@davemloft.net

Sat, Aug 04, 2018 at 01:19:39PM CEST, a@unstable.cc wrote:
>On 04/08/18 17:36, Jiri Pirko wrote:
>>>
>>> Do you have any pointer about where this discussion took place? I
>>> imagine it happened in conjunction with some patches intended to other
>>> drivers/netdev changes.
>>>
>>> Reading that could give us a sense of how strict/important/severe this
>>> decision was and how to prioritize future work.
>>>
>>> I am asking because we have been working on a new feature since several
>>> months and this feature introduces a new sysfs knob.
>>>
>>> Now, although I understand the recommendation of switching to netlink, I
>>> find it a bit impractical to delay a new (and fairly big) feature,
>>> simply because it uses a potentially obsolete, but current, API.
>>>
>>> Any opinion about this?
>> 
>> I agree, that does not make sense.
>
>Thanks for your reply, Jiri.
>
>> 
>> I just wanted you to consider introducing netlink iface and migrate to
>> it as it is generally the preffered way to comunicate with userspace in
>> networking area (I don't have pointer any specific discussion though -
>> it is just a common knowledge :)).
>
>That's ok. I was asking because in the past batman-adv was using debugfs
>for dealing with settings and we were (properly) redirected to sysfs by
>David.
>Now it seems we need to migrate to the next thing :-) So I just wanted
>to be sure we have to do it, but this seems to be the case..
>
>> I will be more then happy to help you
>> with that. You should look at net/core/devlink.c and net/wireless/nl80211.c
>> to get some inspiration.
>
>Actually we have already implemented a basic netlink API to be used when
>sending information to userspace (i.e. routing tables, neighbour tables,
>etc..), therefore I think we might be able to leverage on that.
>But of course, any help will be appreciated :)

Yes, I see net/batman-adv/netlink.c. That looks fine. Shouldn't be hard
to migrate the existing sysfs things there and add new features.
Please don't forget to echo the configured options via netlink
notifications from the very beginning. Feel free to send me patches to
look at.

Thanks!


>
>Thanks!
>
>Cheers,
>
>
>
>-- 
>Antonio Quartulli
>



