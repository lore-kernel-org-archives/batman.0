Return-Path: <jiri@resnulli.us>
Date: Sat, 4 Aug 2018 11:36:32 +0200
From: Jiri Pirko <jiri@resnulli.us>
Message-ID: <20180804093632.GB2015@nanopsycho>
References: <20161027190150.7880-1-sw@simonwunderlich.de>
 <20161027190150.7880-4-sw@simonwunderlich.de>
 <20161029103301.GD1692@nanopsycho.orion>
 <22392280.4UY6GoIrAk@sven-edge>
 <20161029105628.GE1692@nanopsycho.orion>
 <20180327154307.GA2052@otheros>
 <20180520061954.GA2255@nanopsycho.orion>
 <113e9222-3310-71c6-7cec-c253b9b5d194@unstable.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <113e9222-3310-71c6-7cec-c253b9b5d194@unstable.cc>
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

Sat, Aug 04, 2018 at 11:24:11AM CEST, a@unstable.cc wrote:
>Hi Jiri,
>
>On 20/05/18 14:19, Jiri Pirko wrote:
>> Tue, Mar 27, 2018 at 05:43:08PM CEST, linus.luessing@c0d3.blue wrote:
>>> On Sat, Oct 29, 2016 at 12:56:28PM +0200, Jiri Pirko wrote:
>>>>>> I strongly believe it is a huge mistake to use sysfs for things like
>>>>>> this. This should be done via generic netlink api.
>>>>>
>>>>> This doesn't change the problem that it is already that way. This patch
>>>>> only adds the list of available files to the README.
>>>>
>>>> Sure. Just found out you did it like that. Therefore I commented. I
>>>> suggest to rework the api to use genl entirely.
>>>
>>> Hi Jiri,
>>>
>>> Thanks for sharing your thoughts!
>>>
>>> Could you explain a bit more on which disadvantages you see in
>>> the usage of sysfs here?
>> 
>> There are 2 major disadvantages.
>> 1) You don't have any events on a change. An app has to poll in order to
>>    know what changed in kernel. Netlink handles this by sending
>>    multicast messages on a specific socket while whoever is interested
>>    gets the messages.
>> 2) In sysfs, everything is string. There are even mixed values like
>>    "1 (means something)". There are no well defined values. Every driver
>>    can expose same things differently. In Netlink, you have well-defined
>>    attributes, with typed values. You can pass multiple attributes for
>>    the same value if needed.
>> 
>> In general, usage of sysfs in netdev subsystem is frowned upon. I would
>> suggest to convert your iface to Generic Netlink API and let the
>> existing sysfs API to rot.
>
>Do you have any pointer about where this discussion took place? I
>imagine it happened in conjunction with some patches intended to other
>drivers/netdev changes.
>
>Reading that could give us a sense of how strict/important/severe this
>decision was and how to prioritize future work.
>
>I am asking because we have been working on a new feature since several
>months and this feature introduces a new sysfs knob.
>
>Now, although I understand the recommendation of switching to netlink, I
>find it a bit impractical to delay a new (and fairly big) feature,
>simply because it uses a potentially obsolete, but current, API.
>
>Any opinion about this?

I agree, that does not make sense.

I just wanted you to consider introducing netlink iface and migrate to
it as it is generally the preffered way to comunicate with userspace in
networking area (I don't have pointer any specific discussion though -
it is just a common knowledge :)). I will be more then happy to help you
with that. You should look at net/core/devlink.c and net/wireless/nl80211.c
to get some inspiration.


>
>
>Thanks a lot
>
>
>Regards,
>
>
>-- 
>Antonio Quartulli
>



