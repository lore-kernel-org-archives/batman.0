Return-Path: <tcannon@generalpacket.com>
Message-ID: <4EDE971E.4010606@generalpacket.com>
Date: Tue, 06 Dec 2011 14:28:46 -0800
From: Tom Cannon <tcannon@generalpacket.com>
MIME-Version: 1.0
References: <91576D2A759C423D9F749BF369100C1B@FlavioPC>
In-Reply-To: <91576D2A759C423D9F749BF369100C1B@FlavioPC>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] Rede Mesh Batman-ADV in brazil
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is just a guess, but perhaps the bridge is not set to 'auto' and 
will not come up without the lan interface up.

/etc/config/network

config 'interface' 'bridge'
    option 'ifname' 'eth wlan bat'  # replace with your interface names
    option 'type' 'bridge'
    option 'auto' '1'

The option 'auto' ensures the bridge comes up with or without the lan 
port active.
This stumped me once.......

On 12/6/2011 1:00 PM, Flavio Leonel "suporte tecnico" wrote:
>
>
> --------------------------------------------------
> From: "Flavio Leonel "suporte tecnico"" <suporte@tec-wi.com.br>
> Sent: Tuesday, December 06, 2011 6:49 AM
> To: "Sven Eckelmann" <sven@narfation.org>
> Subject: Re: [B.A.T.M.A.N.] Fw: Rede Mesh BatmanADV no brazil
>
>> well what is happening here is the following problem.
>>
>> jah have some nodes with OpenWRT and Ubiquiti with batman-adv 
>> instaldos as I
>> said in another e-mail and could see the pictures.
>>
>> settings:
>> radio interfaces:
>> Physical: 2 a LAN and a WLAN.
>> built-in OpenWRT:
>> mode = wlan mesh
>> = wifi wlan
>> connected to the router lan =
>>
>> All part of a bridge
>> br-lan
>> where this batman-adv active
>>
>> what happens? ..
>> when I disconnect any machine "computer" or router
>> connected to the LAN port of the device or restart.
>>
>> the radio will not let me drop, access ... I no more communication.
>> I have to restart with the same device (computer or router) connected to
>> reestablish connection.
>>
>> already tested it with bridge mode with no firewall
>> and now I'm experimenting with a way forward iptable
>>
>> but without any success not find anything about the forum and do not
>> understand where this error.
>>
>> I hope you can help me, I tried to write my best English
>> grateful ...
>>
>>
