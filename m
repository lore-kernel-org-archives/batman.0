Return-Path: <cmsv@wirelesspt.net>
Message-ID: <5303945C.9000701@wirelesspt.net>
Date: Tue, 18 Feb 2014 12:11:56 -0500
From: cmsv <cmsv@wirelesspt.net>
MIME-Version: 1.0
References: <CACgQMV++TDB_HSdLmXR+GeVWGaVL9dPA7YmGV1F33Ahde0Q7bQ@mail.gmail.com>
 <53031D28.4000006@meshcoding.com>
In-Reply-To: <53031D28.4000006@meshcoding.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] Hiding the ad-hoc network
Reply-To: cmsv@wirelesspt.net,
 The list for a Better Approach To Mobile Ad-hoc Networking
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
To: b.a.t.m.a.n@lists.open-mesh.org

It will also make the mesh principle harder to get working properly
because nodes will need to have some information about the other node in
order to "find it and connect to it"
When used with encryption it will become more complex.

At some point  i also wanted to hide the adhoc. After my research i
decided to take another route.


On 02/18/2014 03:43 AM, Antonio Quartulli wrote:
> On 18/02/14 09:41, Dirk van der Walt wrote:
>> Hi List,
>>
>> Although not strictly Batman-adv related I was wondering if someone
>> here knows how to 'hide' the Ad-hoc network of the mesh.
>>
>> Another person asked the same on the OpenWrt forum but no-one gave him
>> a proper or clear answer:
>>
>> https://forum.openwrt.org/viewtopic.php?id=44665
>>
>> I've managed to get hold of him and he said he still has no clear
>> answer on this one.
>>
> 
> "Hiding" means not broadcasting the SSID (like it can be configured for
> AP mode) and this is not allowed by the current cfg/mac80211 kernel module.
> It is quite out of the standard and requires some "hacks" that the
> maintainers will probably never like.
> 
> 
> Regards,
> 
> 
