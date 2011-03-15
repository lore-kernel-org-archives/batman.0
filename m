Return-Path: <tcannon@generalpacket.com>
Message-ID: <4D7FB3CF.3030604@generalpacket.com>
Date: Tue, 15 Mar 2011 11:45:35 -0700
From: Tom Cannon <tcannon@generalpacket.com>
MIME-Version: 1.0
References: <AANLkTikR_oUzLcEb+=AUR_1bWZR_bS2VgKPcC6RVVd+c@mail.gmail.com>	<AANLkTimBOF10A2M+W4L2nNnKX9t+jr=Y3E3fBRCDvj10@mail.gmail.com>	<AANLkTinB+JVEe7vaYGde5O-yHt3WEUyXQPa0CnExp_r2@mail.gmail.com>	<201103151911.51091.sven@narfation.org>
	<AANLkTikTD7Ks_RmRT_yoVm3_16w4u48mK6t4XD2H5Zjr@mail.gmail.com>
In-Reply-To: <AANLkTikTD7Ks_RmRT_yoVm3_16w4u48mK6t4XD2H5Zjr@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] Wireless Bridge
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org, ahmed.boori@gmail.com

It is unlikely your dsl modem can run any mesh protocol.  (The Open-Mesh 
OM1P runs "Robin", which uses olsr)

However, if you have the Open-Mesh OM1P device, you can reflash it with 
OpenWrt and turn it into a WDS repeater, assuming your dsl modem 
supports this.

Your best source of information on robin and OM1P is here: 
http://robin.forumup.it/

OM1P as a generic AP is discussed here: 
http://robin.forumup.it/about1534-robin.html

If you have the newer Open-Mesh MR500, you are out of luck.  That 
firmware is not open-source.



On 3/15/2011 11:19 AM, A. AlBoori wrote:
> Thank You for your reply. Yes however it runs B.A.T.M.A.N mesh
> protocol.  I wonder. is it possible to do it?
>
> If yes, what configuration/commands i have to do?
>
> Regards,
>
> On 15 March 2011 21:11, Sven Eckelmann<sven@narfation.org>  wrote:
>> On Tuesday 15 March 2011 18:58:16 A. AlBoori wrote:
>>> Good Day all,
>>> I have Wireless DSL router and  Open Mesh Router.
>> Open Mesh router == a router from open-mesh.com? We are not related to
>> open-mesh.com
>>
>> Kind regards,
>>         Sven
>>
