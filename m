Return-Path: <michael.rack@rsm-freilassing.de>
Message-ID: <4AA50D60.9050605@rsm-freilassing.de>
Date: Mon, 07 Sep 2009 15:40:48 +0200
From: Michael Rack <michael.rack@rsm-freilassing.de>
MIME-Version: 1.0
References: <4AA34865.9000203@rsm-freilassing.de>	<200909070147.05443.lindner_marek@yahoo.de>	<4AA4DD8F.8000705@rsm-freilassing.de>
	<200909072102.57854.lindner_marek@yahoo.de>
In-Reply-To: <200909072102.57854.lindner_marek@yahoo.de>
Content-Type: multipart/mixed; boundary="------------020808020001010306020802"
Subject: Re: [B.A.T.M.A.N.] Problems with Gateway-Selection without option -g
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

This is a multi-part message in MIME format.
--------------020808020001010306020802
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Am 07.09.2009 15:02, schrieb Marek Lindner:
> And what is the MTU of the interface batman is running on ?
>
> Did the iptables command I posted help you to fix your MSS problem ?
>
>    
The interface where batman is running on have MTU 1460 (Standard 
Ethernet - UDP VPN Overload) on HOST #1.
The interface where batman is running on have MTU 1500 (Standard 
Ethernet) on HOST #2.
Yes, the iptables-command does the trick for me. This iptalbes-filter 
was known before. I added the filter to the mangle-table as the problem 
occurs.

My Root-Server (HOST #1) is located at Nuernberg, DE and have access to 
the internet with a public ip-space /22 that allocated to me. HOST #2 is 
connected to an lowcost ISP-Provider with 30MBits / 2MBits. HOST #2 is 
connected by VPN with HOST #1 to route the public ip-addresses.
>> IP-Host #1: 123.205.12.0 / 32
>> IP-Host #2: 123.205.12.4 / 32
>>
>> IP RULES ON "HOST #2":
>> ~ $ /sbin/ip rule show
>> 6600:    to 123.205.12.4 lookup batman_hosts [66]
>> 6601:    from all lookup batman_networks [65]
>> 6700:    to 123.205.12.4 lookup batman_unreach [67]
>>
>> Host #1 (123.205.12.0) is in the routingtable of batman_hosts [66].
>>
>> But i can not ping 123.205.12.0, because the kernel will not enter the
>> rule 6600.
>>
>> When i configure my Host #2 to a /24 network, all went fine. Then the
>> rule will setuped as follow:
>>
>> 6600:    to 123.205.12.4/24 lookup batman_hosts [66]
>>      
> Ok, I see your problem. Batman could easily detect whether the host is part of
> any existing network and if not modify the routing rules. I see 2 options:
> * adding more rules to jump in table 66
> * adding the node to table 65 instead of 66
>    
Correct. I've added some rules with "to any", and this does the trick. 
In addition i use my own policy-routing-script, because the "throw" 
event makes the routing-table a little fuzzy. Now i have only two 
routing-tables "batman_hosts" and "batman_networks". In my 
policy-routing-script i do the seperation between both tables.
> What did you do to make it work ?
>    
My policy-routing-script is attached.

Michael.


--------------020808020001010306020802
Content-Type: text/plain;
 name="policy_routing_script.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="policy_routing_script.sh"

#!/bin/sh
LOG_FILE="/var/log/batman-routing.log"
echo "" > $LOG_FILE
date=(/bin/date +"%Y-%m-%d %H:%M:%S")

while read method action mtype dst mask gw src_ip ifi_prio dev table
do
	if [ "$method" == "ROUTE" ]
	then
		if [ "$mtype" == "UNICAST" ]
		then
			if [ "$mask" == "32" -a "$table" == "66" ]
			then
				# HOST-Route
				if [ "$action" == "add" ]
				then
					if [ "$gw" == "$dst" ]
					then
						# DIRECT NEIGHBOUR
						/sbin/ip route add $dst src $src_ip dev $dev table $table
						echo "Add neighbour: $dst reached by $src_ip@$dev" >> $LOG_FILE
					else
						# TWO-HOP NEIGHBOUR
						/sbin/ip route add $dst/$mask via $gw src $src_ip dev $dev table $table
						echo "Add host: $dst via $gw reached by $src_ip@$dev" >> $LOG_FILE
					fi
				elif [ "$action" == "del" ]
				then
				# Remove a HOST-Route
					/sbin/ip route del $dst table $table
					echo "Delete neighbour: $dst" >> $LOG_FILE
				fi
			elif [ "$mask" != "32" -a "$table" == "65" ]
			then
				# NETWORK-Announcement
				if [ "$action" == "add" ]
				then
					# Add Network
					/sbin/ip route add $dst/$mask via $gw src $src_ip dev $dev table $table
					echo "Add network: $dst/$mask via $gw reached by $src_ip@$dev" >> $LOG_FILE
				elif [ "$action" == "del" ]
				then
					# Remove Network
					/sbin/ip route del $dst/$mask via $gw table $table
					echo "Add network: $dst/$mask via $gw" >> $LOG_FILE
				fi
			fi
		fi
	fi
done

--------------020808020001010306020802--
