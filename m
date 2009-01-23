From: elektra <onelektra@gmx.net>
Date: Fri, 23 Jan 2009 11:01:54 +0100
References: <278AF6CA06F13D4C9E9F69C7B9AB3B8303504611@MBX21.stu.nus.edu.sg>
	<200901211621.21753.sven.eckelmann@gmx.de>
	<278AF6CA06F13D4C9E9F69C7B9AB3B8303504624@MBX21.stu.nus.edu.sg>
In-Reply-To: <278AF6CA06F13D4C9E9F69C7B9AB3B8303504624@MBX21.stu.nus.edu.sg>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200901231101.55035.onelektra@gmx.net>
Subject: Re: [B.A.T.M.A.N.] Install Batman
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Hi Kartik -

please provide info about the error message... 

Of course you have to set up the wireless interface...

Here is the startup-script I use on my laptop:

# Load the tun kernel module
modprobe tun

# Create Ahdemo mode Madwifi wireless VAP
wlanconfig ath0 create wlandev wifi0 wlanmode ahdemo

# Create  /etc/resolv.conf with preferred domain name server 
echo "nameserver 141.1.1.1" > /etc/resolv.conf

# Set up wireless essid, channel and fix the IBSS-ID to avoid cell-splitting 
# - mandatory to join an existing cell in Ahdemo mode
iwconfig ath0 essid olsr.freifunk.net channel 10 ap 02:CA:FF:EE:BA:BE

# Configure IP of VAP interface
ip a add 103.130.30.10/8 brd 103.255.255.255 dev ath0 

# Switch it on.
ip link set ath0 up

# Start batmand with preferred internet gateway
batmand  -p 103.130.1.67 ath0 

cu elektra
