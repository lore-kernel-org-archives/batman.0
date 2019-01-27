Return-Path: <jiri@resnulli.us>
Date: Sun, 27 Jan 2019 09:45:16 +0100
From: Jiri Pirko <jiri@resnulli.us>
Message-ID: <20190127084516.GA2151@nanopsycho>
References: <20190119155626.6414-1-sven@narfation.org>
 <1895931.G10psR3j26@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1895931.G10psR3j26@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [RFC v4 00/19] batman-adv: netlink restructuring, part 2
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
Cc: b.a.t.m.a.n@lists.open-mesh.org, Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org, linus.luessing@c0d3.blue

Sat, Jan 26, 2019 at 11:47:20AM CET, sven@narfation.org wrote:
>On Saturday, 19 January 2019 16.56.07 CET Sven Eckelmann wrote:
>[...]
>> There were also two topics which were not yet really discussed and thus
>> these requests (from Linus) were not yet implemented:
>
>@Jiri, @Linus maybe you can discuss these topics further and select the 
>correct solution.
>
>> * convert BATADV_ATTR_MULTICAST_MODE_ENABLED to an u32 and let don't handle
>>   it like a boolean. Instead use it to select how multicast traffic has to
>>   be handled:
>>   
>>   - 0: ignore multicast optimization and just flood it like broadcast
>>     traffic
>>   - 1: enabled multicast optimization
>>   - 2: undefined but also some kind of multicast optimization
>>   - 3: undefined but also some kind of multicast of optimization
>>   - ...
>
>Multicast mode is currently defined.
>
>* according to batctl manpage:
>
>    multicast_mode|mm [0|1]
>           If no parameter is given the current multicast mode set‐
>           ting is displayed. Otherwise the parameter is used to en‐
>           able or disable multicast optimizations (i.e. disabling
>           means always sending own multicast frames via classic
>           flooding).
>
>* according to sysfs ABI:
>
>   What:           /sys/class/net/<mesh_iface>/mesh/multicast_mode
>   Date:           Feb 2014
>   Contact:        Linus Lüssing <linus.luessing@web.de>
>   Description:
>                   Indicates whether multicast optimizations are enabled
>                   or disabled. If set to zero then all nodes in the
>                   mesh are going to use classic flooding for any
>                   multicast packet with no optimizations.
>
>Both define it as boolean value and therefore it was converted to a boolean 
>value (via u8) in netlink.
>
>But Linus now suggested that it is actually an u32. Most likely 0 == to 
>something like BATADV_MULTICAST_MODE_FLOODING. But I have no idea what 1 is or 
>what 2, 3, 4, .. would be. So I need some input here.
>
>And Jiri said that it should be renamed to BATADV_ATTR_MULTICAST_ENABLED -
>which seems to suggest that he doesn't like the idea of a u32 for some reason
>and prefers to use a boolean value.
>
>And now Linus even said that it should be a bit field - which makes it even 
>more vague to me and I have now absolutely no idea what should be implemented.

If it is bool, it should be bool. If it is a bitfield (future more bits
than one needed), it should be a bitfield.


>
>* BIT 0 for flooding vs ?
>* BIT 1 for ?
>* ...
>
>> * convert BATADV_ATTR_AGGREGATION_OGM_ENABLED to u32 and use it
>>   to mark which type of traffic should be aggregated:
>> 
>>   - bit 0: enable aggregation of OGM(2)s
>>   - bit 1: yet undefined packet type which allows some kind of aggregation
>>   - bit 2: yet undefined packet type which allows some kind of aggregation
>>   - ...
>
>Aggregated OGM is currently defined as:
>
>
>* according to batctl manpage:
>
>    aggregation|ag [0|1]
>           If no parameter is given the current aggregation setting
>           is displayed. Otherwise the parameter is used to enable or
>           disable OGM packet aggregation.
>
>* according to sysfs ABI:
>
>    What:           /sys/class/net/<mesh_iface>/mesh/aggregated_ogms
>    Date:           May 2010
>    Contact:        Marek Lindner <mareklindner@neomailbox.ch>
>    Description:
>                    Indicates whether the batman protocol messages of the
>                    mesh <mesh_iface> shall be aggregated or not.
>
>So sysfs is only one possible backend for the batctl command. There is 
>currently nothing which I would assume to be aggregatable beside OGMs but let 
>us assume for now that there is now something and some way to aggregate things 
>beside OGMs in a save and backward compatible way. Let's call this FOO - so we 
>have BATADV_ATTR_AGGREGATION_OGM_ENABLED and 
>BATADV_ATTR_AGGREGATION_FOO_ENABLED. Or we have BATADV_ATTR_AGGREGATION as an 
>u32 and just use the second bit as marker for FOO (and of course the first bit 
>as marker for OGM).
>
>Would it now be more preferable to use BATADV_ATTR_AGGREGATION_OGM_ENABLED as 
>u8 (boolean) or to to switch to BATADV_ATTR_AGGREGATION (u32) & assign single 
>bits to packet types.
>
>Kind regards,
>	Sven


