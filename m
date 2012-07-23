Return-Path: <nicoechaniz@codigosur.org>
Message-ID: <500D1339.80702@codigosur.org>
Date: Mon, 23 Jul 2012 06:02:49 -0300
From: =?UTF-8?B?Tmljb2zDoXMgRWNow6FuaXo=?= <nicoechaniz@codigosur.org>
MIME-Version: 1.0
References: <5008C14B.6040707@codigosur.org>
 <201207221320.14242.lindner_marek@yahoo.de>
In-Reply-To: <201207221320.14242.lindner_marek@yahoo.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] batman-adv not selecting a gateway when using
 "client 1" through uci config
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On 07/22/2012 08:20 AM, Marek Lindner wrote:
> On Friday, July 20, 2012 04:24:11 Nicolás Echániz wrote:
>> there's no gateway being selected until I manually run:
>> # batctl gw_mode client 1
>> (which was te current mode anyway)
>> on each client.
>>
>> In fact, connected computers are not being served DHCP offers because of
>> this.
>>
>> Is this some known behavior or just something I overlooked?
> 
> In fact you managed to uncover a regression that was overlooked for quite some 
> time. Guess gw selection class 1 is rarely used.  :-)
> 
> Can you apply the attached patch and verify that it fixes the problem ? Here 
> in my test setup it does.

Marek patch applied (thanks Guido) and verified.
gw_mode client 1 is now properly selecting a gateway when set in the config.

thanks for your prompt reply :)

cheers,
NicoEchániz
