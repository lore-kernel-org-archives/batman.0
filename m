Return-Path: <jiri@resnulli.us>
Date: Sat, 29 Oct 2016 15:51:33 +0200
From: Jiri Pirko <jiri@resnulli.us>
Message-ID: <20161029135133.GG1692@nanopsycho.orion>
References: <20161027190150.7880-1-sw@simonwunderlich.de>
 <22392280.4UY6GoIrAk@sven-edge>
 <20161029105628.GE1692@nanopsycho.orion>
 <2528373.sE2IHzpoFy@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2528373.sE2IHzpoFy@sven-edge>
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
To: Sven Eckelmann <sven@narfation.org>
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net

Sat, Oct 29, 2016 at 01:46:59PM CEST, sven@narfation.org wrote:
>On Samstag, 29. Oktober 2016 12:56:28 CEST Jiri Pirko wrote:
>[...]
>> >> I strongly believe it is a huge mistake to use sysfs for things like
>> >> this. This should be done via generic netlink api.
>> >
>> >This doesn't change the problem that it is already that way. This patch
>> >only adds the list of available files to the README.
>> 
>> Sure. Just found out you did it like that. Therefore I commented. I
>> suggest to rework the api to use genl entirely.
>
>Fair enough, I have added it to the issue tracker [1].
>
>It seems there is no easy way to drop support for modifying batman-adv
>attributes of the interface or its ports via sysfs in the near
>future. But disallowing sysfs for new attributes might be a viable
>policy.

Cool. Thanks!


>
>Kind regards,
>	Sven
>
>[1] https://www.open-mesh.org/issues/300


