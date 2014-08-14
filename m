Return-Path: <liudows@aliyun.com>
Message-ID: <53EC5D49.5000705@aliyun.com>
Date: Thu, 14 Aug 2014 14:55:05 +0800
From: liu <liudows@aliyun.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] how to compile the latest version of batctl in
	OpenWrt 12.09
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

Hello, I try to test the latest version of batman-adv in OpenWrt 12.09. 
I failed to compile 'batctl' because of the old version of 'libnl' in 
OpenWrt.The version '2014.3' and the development version of 'batctl' 
require 'libnl-3.0', but OpenWrt 12.09 only contain the 'libnl-2.0.1'. 
That's the problem. How to fix this? Anyone have built it in OpenWrt 
12.09 yet?

Thanks.

Best regards

liu


