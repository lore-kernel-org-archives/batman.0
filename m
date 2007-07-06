Message-ID: <468DEE47.6080106@fokus.fraunhofer.de>
Date: Fri, 06 Jul 2007 09:24:55 +0200
From: Anton Gillert <anton.gillert@fokus.fraunhofer.de>
MIME-Version: 1.0
References: <200707051000.l65A02Y3020074@open-mesh.net>
In-Reply-To: <200707051000.l65A02Y3020074@open-mesh.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] Re: Batman problem with tun0
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net


> Hi,
>
>   
>> I have two Asus wl500gp router, each with atheros(Atheros 5212)
>> wlancards, running kamikaze 7.06; kernel ver.:2.6.19.2. and B.A.T.M.A.N.
>> 0.2 rv451 (compability version 3)
>> one of them has access to the internet.
>> The one who has no internet connection, doesn't set a default route to
>> the one who has. It only sets this routes:
>>     
>
> it looks quite good so far. Blocked TCP is the most obvious reason that the 
> tun device does not appear. the client tries to establish a TCP control 
> channel (port 1967) to the gateway. If that connection attempt is ignored no 
> default route will be set.
>
> Regards,
> Marek
>
>   
Hello,

thanks for replying so fast. Unfortunately the reason isn't the blocked 
tcp-port, I tested it after I shutdown the firewall on each node with 
the same result as you can see above. Is there something else I can do?

Best regards

Anton


