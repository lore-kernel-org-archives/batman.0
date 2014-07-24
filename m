Return-Path: <gtolon@inti.gob.ar>
Message-ID: <53D0FE56.1080503@inti.gob.ar>
Date: Thu, 24 Jul 2014 09:38:46 -0300
From: =?UTF-8?B?R2FicmllbCBUb2zDs24=?= <gtolon@inti.gob.ar>
MIME-Version: 1.0
References: <53C91BDF.3080907@inti.gob.ar> <53CFDBC0.3020906@altermundi.net>
In-Reply-To: <53CFDBC0.3020906@altermundi.net>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] non DHCP batman-adv gateway
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hi Gui, thanks for your answer!


El 23/07/14 12:58, Gui Iribarren escribió:
> On 18/07/14 10:06, Gabriel Tolón wrote:
>> Hi,
>>
>> I'd like to use a configuration in a batman-adv openwrt mesh network in
>> which the batman gateway relays the DHCP messages to and from a non
>> batman-adv router. I think that's not a typical configuration right?
>> Should it work? Do I need some additional packages? Thanks in advance!
>
> Yes, it should work just fine, you should set gw_mode=master in the
> correspondent batman-adv gateway, but turn its dhcp server off.

you mean gw_mode=server? Or it's a new option?

>
> So, when dhcp packets get to that node, it will naturally relay them
> over br-lan and they will reach the non-batman-adv router.
>
> That setup is more typical than what you might think of :)
>
> (we have used it this way in at least 4 or 5 different cases)
>
> cheers!

That's good to know. Other option I had thought was to turn off gw_mode 
and use the mesh just as the L2 switch it is, but that way the 
possibility to choose the best batman-adv gateway would be lost i guess.

Regards

Gabriel
