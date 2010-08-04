Return-Path: <Timbo2001@web.de>
Message-ID: <4C59311F.7040500@web.de>
Date: Wed, 04 Aug 2010 11:21:35 +0200
From: Tim <Timbo2001@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: Timbo2001@web.de
Subject: [B.A.T.M.A.N.] Problem openWRT "backfire" and "kmod-batman-adv"
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hello,

I'm trying to build an mesh network with B.A.T.M.A.N Advanced for my 
bachelor's thesis. Building an Image used to be no problem when the 
Batman-package was called "kmod-batman-adv-kernelland". Since there is 
only "kmod-batman-adv" in the OpenWRT repositories I have the following 
problem: Compiling, transferring and connecting is no problem, but after 
I change some settings in "/etc/config/network" and 
"/etc/config/wireless" and restart the router the power led keeps 
flashing and there's no possibility to connect to the device anymore. 
Only ping is working with the ip I set it to.... When doing only a 
network restart via /etc/init.d/network restart the device shows: 
"Segmentation fault" and then freezes.

I tried compiling an Image on either 32 and 64 bit Ubuntu / Kubuntu.

Do you have any suggestions?

With best regards,
Tim
