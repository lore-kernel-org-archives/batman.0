Return-Path: <ufo@rund.freifunk.net>
References: <55BCEE50.3080600@rund.freifunk.net> <2676271.FVut4a8TrS@sven-edge>
From: Ufo <ufo@rund.freifunk.net>
Message-ID: <56694780.2010902@rund.freifunk.net>
Date: Thu, 10 Dec 2015 10:36:00 +0100
MIME-Version: 1.0
In-Reply-To: <2676271.FVut4a8TrS@sven-edge>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] old batman-adv within 15.05 brunch?
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

so who wants to do that? :-o
or maybe there are other purposes to keep the older version within 15-05 
brunch?

On 01.08.2015 20:27, Sven Eckelmann wrote:
> On Saturday 01 August 2015 18:05:36 Ufo wrote:
>> is there a reason for staying with batman-adv 2014 for openwrt 15.05?
>>
>> our current freifunk leipzig running batman-adv 2015.0 and it seems to work
>>
>> https://github.com/openwrt-routing/packages/tree/master/batman-adv
>>
>> vs.
>>
>> https://github.com/openwrt-routing/packages/tree/for-15.05/batman-adv
> I would even say that it should switch to 2015.1 (not yet released) because it
> fixes some nasty problems:
>
> batman-adv 2015.1
>
>   * support latest kernels (2.6.29 - 4.2)
>   * cleanup of coding style
>   * cleanup of the compatibility layer
>   * convert to the Linux source directory structure
>   * adjust default configuration
>     - disable network coding
>     - enable bridge loop avoidance
>   * bugs squashed:
>     - avoid DAT to mess up local LAN state
>     - fix race conditions in DAT/NC/TT/MCAST TVLV handlers
>     - fix build system POSIX compatibility
>     - fix gateway selection in fast connection (1) gw_mode
>     - fix initialization of detected gateway
>     - fix race conditions in the translation table
>     - fix kernel crash due to missing NULL checks in vlan handlers
>     - fix potentially broken header access by multicast optimization
>     - fix broadcast packets cleanup for purged outgoing interface
>
>   -- XXX, XX Aug 2015 XX:XX:XX +0200
>
> batman-adv 2015.0
>
>   * support latest kernels (2.6.29 - 4.1)
>   * cleanup of coding style and add kerneldoc
>   * bugs squashed:
>     - fix incorrect lockdep warning in network coding
>     - fix condition when bonding should be used
>     - fix support of bridged batman-adv devices with kernel < 2.6.39
>
>   -- Tue, 28 Apr 2015 20:20:02 +0200

