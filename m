Return-Path: <ilario.gelmetti@sns.it>
From: "Ilario GELMETTI" <ilario.gelmetti@sns.it>
Date: Tue, 01 Apr 2014 11:33:01 +0200
Message-ID: <web-133442820@sns.it>
In-Reply-To: <5339CBBD.9050708@sns.it>
References: <5339CBBD.9050708@sns.it>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] br-lan: received packet on bat0 with own address
	as source address
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

On Mon, 31 Mar 2014 22:10:37 +0200
 Ilario Gelmetti <ilario.gelmetti@sns.it> wrote:
> I have two devices (Ubiquiti PicoStation M2 and Ubiquiti NanoStation M5)
> mounted on the same pole both running libre-mesh [1] firmware
> (batman-adv: 2014.1.0) and both attached to a Mikrotik RB250GS gigabit
> switch (latest 1.11 firmware, default configuration)
> ...
> Both the devices independently (also when are isolated) print the same
> error in dmesg:
> br-lan: received packet on bat0 with own address as source address

On libre-mesh mailing list there's a solution suggesting to change a mac addresses:
http://lists.libre-mesh.org/pipermail/dev/2014-April/000316.html
I tried changing the mac address
config interface 'lm_eth0_batadv'                  
        option ifname 'eth0.11'                    
        option proto 'batadv'                      
        option mesh 'bat0'                         
        option mtu '1496'                          
        option macaddr 'dc:9f:db:31:c1:38' 
and that error in dmesg went away.
